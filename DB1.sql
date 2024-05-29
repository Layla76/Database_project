create table wages(
                                id number(10) primary key,
                                jobId number(10) references jobs
                                types varchar(50),
                                wage float
                  );
                  
create table procurements(
                                id number(10) primary key,
                                types varchar(50)
                         );

create table subscriptions(
                                id number(10) primary key,
                                types varchar(50),
                                cost float,
                                isRenewable number(1)
                          );

create table penalties(
                                id number(10) primary key,
                                types varchar(50),
                                fee float
                      );

create table insurance(
                                id number(10) primary key,
                                providerId number(10) references providers,
                                plan varchar(50),
                                cost float
                      );

create table funding(
                                id number(10) primary key,
                                types varchar(50)
                    );

create table employees(
                               id number(9) primary key
                      );
                  
create table books(
                               id number(10) primary key
                  );

create table members(
                                id number(9) primary key
                    );

create table insurableEntities(
                                id number(10) primary key
                              );

create table fundingSources(
                                id number(10) primary key
                          );

create table jobs(
                                id number(10) primary key
                );

create table providers(
                                id number(10) primary key
                      );