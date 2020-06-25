import { NORTH_AMERICA_CODES, SOUTH_AMERICA_CODES} from './util/constants';

cube(`Countries`, {
  sql: `SELECT * FROM store.countries`,
  title: `Países`,
  
  joins: {
    
  },
  
  measures: {
    count: {
      type: `count`,
      drillMembers: [id, name],
      shown: false
    }
  },
  
  dimensions: {
    continent: {
      type: `string`,
      title: `Continente`,
      case: {
        when: [
          {sql: `${CUBE}.code in ('${SOUTH_AMERICA_CODES.join("','")}')`, label: `Sur América` },
          {sql: `${CUBE}.code in ('${NORTH_AMERICA_CODES.join("','")}')`, label: `Norte América` }
        ]
      }
    },

    code: {
      sql: `code`,
      type: `string`,
      shown: false
    },
    
    id: {
      sql: `id`,
      type: `number`,
      primaryKey: true,
    },
    
    name: {
      sql: `name`,
      type: `string`,
      shown: false
    }
  },
  segments: {
    southAmerica: {
      title: `Sur América`,
      sql: `${Countries.code} in ('${SOUTH_AMERICA_CODES.join("','")}')`
    },
    northAmerica: {
      title: `Norte América`,
      sql: `${Countries.code} in ('${NORTH_AMERICA_CODES.join("','")}')`
    }
  }
});
