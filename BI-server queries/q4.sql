-- What’s the average outstanding at the start of the lease per team and lane?

SELECT les.team
     , les.lane
     , AVG(outstanding_start)
FROM dmt.fct_leases fct

INNER JOIN dmt.dim_leases les
ON (les.leases_sk = fct.leases_sk)

INNER JOIN dmt.dim_jnk_installments din
ON(din.installments_sk = fct.installments_sk)

WHERE din.ind_start_date = 1

GROUP BY les.team
       , les.lane;