# simple_paginate

[![Build Status](https://travis-ci.org/xinminlabs/simple_paginate.png)](https://travis-ci.org/xinminlabs/simple_paginate)

Simple pagination solution for previous and next page navigation.

## Why simple_paginate

We saw some websites using `will_paginate` or `kaminari` for pagination, but they just need previous and next page navigation, `will_paginate` or `kaminari` is overqualified.

Pagination in databae sometimes is slow because

1. it sends a sql with OFFSET to get collection
2. it sends additional sql with COUNT to get total number of record.

`simple_paginate` eliminates the additional COUNT sql, make your pagination faster.

## How simple_paginate works

`will_paginate` and `kaminari` uses `page` and `per_page` to calculate offset and limit, then send 2 sqls

```
SELECT * FROM posts OFFSET 20 LIMIT 10;
SELECT COUNT(*) FROM posts;
```

after getting total count, they can calculate total pages, then render page numbers, prev, next, first and last page links.

`simple_paginate` also uses `page` and `per_page` to calculate offset and limit, but it only sends 1 sql

```
SELECT * FROM posts OFFSET 20 LIMIT 11;
```

it fetches one more record (11 = 10 + 1) to calculate if there is a next page records, so it doesn't need to send COUNT sql.

## Usage

### Query Basics

```
## perform a paginate query:
@users = User.paginate(:page => params[:page])

# or, use page and per scope:
@users = User.page(params[:page]).per(25)
```

### Helpers 

```
## render previous page link:
<%= link_to_previous_page @users, 'Previous' %>

## render next page link:
<%= link_to_next_page @users, 'Next' %>

## render previous page link and next page link
<%= simple_paginate @users
```

### General configuration options

You can configure the following default values by overriding these values using SimplePaginate.configure method.

```
default_per_page    # 25 by default
```

There's a handy generator that generates the default configuration file into config/initializers directory. Run the following generator command, then edit the generated file.

```
% rails g simple_paginate:config
```

### Customizing the pagination helper

SimplePaginate includes a handy template generator, To edit your paginator, run the generator first:

```
% rails g simple_paginate:views 
```

### Contribute

To run the test suite locally:

```
% bundle install
% rake spec:active_record_42
```
