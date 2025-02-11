 {{config(materialized = 'table', schema = 'transforming_dev')}}
 
with recursive managers
     
      (indent, officeid, employee_id, manager_id, employee_title, manager_title, employee_name, manager_name)
    as
      (
 
        -- Anchor Clause
        select '*' as indent, office, empid, cast(IFF(reporsto is null, empid, reporsto) as number),
        title as employee_title, title as manager_title, lastname as employee_name, lastname as manager_name 
        from {{ref('stg_employee')}}
          where title = 'President'
 
        union all
 
        -- Recursive Clause
        select
            indent || ' *' as indent, emp.office, emp.empid, emp.reporsto, emp.title,
            mgr.employee_title, emp.lastname as employee_name, mgr.employee_name as manager_name
          from {{ref('stg_employee')}} as emp inner join managers as mgr
            on emp.reporsto = mgr.employee_id
      ),
 
      offices (officeid, officecity, officecountry)
      as
      (
      select office, officecity, officecountry from {{ref('stg_office')}}
      )
 
  -- This is the "main select".
  select managers.indent, managers.employee_id, offices.officecity, offices.officecountry,
  managers.employee_title, managers.manager_id, managers.manager_title, managers.employee_name,
  managers.manager_name
    from managers left join offices on managers.officeid = offices.officeid
 