#include <db.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <pthread.h>

void print_error(int ret)
{
        if (0 != ret) {
                printf("ERROR: %s\n", db_strerror(ret));
        }
}

void init_DBT(DBT *key, DBT *data)
{
        memset(key, 0, sizeof(DBT));
        memset(data, 0, sizeof(DBT));
}

int main(int argc, char *argv[])
{
        DB *dbp;

        DBT key, data;

        u_int32_t flags;

        int ret;

        char *fruit = "apple";

        int number = 15;

        typedef struct customer {
                int id;
                char name[10];
                char address[20];
                int age;
        } CUSTOMER;

        CUSTOMER cust;

        int key_cust_c_id = 1;

        cust.id = 1;

        strncpy(cust.name, "Javer", 9);
        strncpy(cust.address, "chengdu", 19);

        cust.age = 32;

        ret = db_create(&dbp, NULL, 0);

        print_error(ret);

        flags = DB_CREATE;

        ret = dbp->open(dbp, NULL, "single.db", NULL, DB_BTREE, flags, 0);

        print_error(ret);

        init_DBT(&key, &data);

        key.data = fruit;
        key.size = strlen(fruit) + 1;

        data.data = &number;
        data.size = sizeof(int);

        ret = dbp->put(dbp, NULL, &key, &data, DB_NOOVERWRITE);


        print_error(ret);

        /* flush into disk */
        dbp->sync(dbp, 0);

        init_DBT(&key, &data);

        key.data = fruit;
        key.size = strlen(fruit) + 1;

        ret = dbp->get(dbp, NULL, &key, &data, 0);
        print_error(ret);

        printf("The number = %d\n", *(int *)(data.data));

        if (NULL != dbp) {
                dbp->close(dbp, 0);
        }

        ret = db_create(&dbp, NULL, 0);

        print_error(ret);

        flags = DB_CREATE;
        ret = dbp->open(dbp, NULL, "complex.db", NULL, DB_HASH, flags, 0); 
        print_error(ret);
        init_DBT(&key, &data);
        key.size = sizeof(int);
        key.data = &(cust.id);
        data.size = sizeof(CUSTOMER);
        data.data = &cust;
        ret = dbp->put(dbp, NULL, &key, &data, DB_NOOVERWRITE);
        print_error(ret);

        memset(&cust, 0, sizeof(CUSTOMER));

        key.size = sizeof(int);
        key.data = &key_cust_c_id;
        data.data = &cust;
        data.ulen = sizeof(CUSTOMER); 
        data.flags = DB_DBT_USERMEM;
        dbp->get(dbp, NULL, &key, &data, 0);
        print_error(ret);

        printf("c_id = %d name = %s address = %s age = %d\n", 
                        cust.id, cust.name, cust.address, cust.age);

        if(dbp != NULL)
                dbp->close(dbp, 0); 

        return 0;
}
