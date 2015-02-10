# simple_paginate

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
