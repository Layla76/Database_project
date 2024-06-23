CREATE
UNIQUE INDEX grants_index
ON grants (funding_source_id, funding_id, amount, date_);

CREATE
UNIQUE INDEX subscribed_index
ON subscribed (subscription_id, member_id, start_date_);

CREATE
UNIQUE INDEX receives_index
ON receives (member_id, penalty_id, issue_date);