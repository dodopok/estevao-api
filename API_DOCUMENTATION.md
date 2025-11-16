# Estevão API - Liturgical Calendar API Documentation

A comprehensive Anglican/Episcopal liturgical calendar API providing liturgical information for any date.

## Base URL

```
https://your-domain.com/api/v1
```

## Endpoints

### Get Liturgical Information for a Specific Day

```http
GET /calendar/:year/:month/:day
```

Returns complete liturgical information for a specific date.

**Parameters:**
- `year` (integer, required): Year (1900-2200)
- `month` (integer, required): Month (1-12)
- `day` (integer, required): Day (1-31)

**Example Request:**
```bash
GET /api/v1/calendar/2025/11/16
```

**Example Response:**
```json
{
  "date": "2025-11-16",
  "day_of_week": "Sunday",
  "liturgical_season": "Ordinary Time",
  "liturgical_color": "green",
  "liturgical_year": "C",
  "is_sunday": true,
  "is_holy_day": null,
  "sunday_name": "25th Sunday in Ordinary Time",
  "week_of_season": 25,
  "proper_week": 28,
  "sunday_after_pentecost": 24,
  "celebration": null,
  "saint": null,
  "collect": {
    "text": "Prayer text here..."
  },
  "readings": {
    "first_reading": "Isaiah 65:17-25",
    "psalm": "Psalm 98",
    "second_reading": "2 Thessalonians 3:6-13",
    "gospel": "Luke 21:5-19"
  }
}
```

### Get Liturgical Calendar for a Month

```http
GET /calendar/:year/:month
```

Returns liturgical information for all days in a month.

**Parameters:**
- `year` (integer, required): Year (1900-2200)
- `month` (integer, required): Month (1-12)

**Example Request:**
```bash
GET /api/v1/calendar/2025/12
```

**Example Response:**
```json
{
  "year": 2025,
  "month": 12,
  "month_name": "Dezembro",
  "days": [
    {
      "date": "2025-12-01",
      "day_of_week": "Monday",
      "liturgical_season": "Advent",
      "liturgical_color": "violet",
      "liturgical_year": "B",
      "is_sunday": false,
      ...
    },
    ...
  ]
}
```

### Get Year Overview

```http
GET /calendar/:year
```

Returns summary information for the liturgical year including movable dates and important feasts.

**Parameters:**
- `year` (integer, required): Year (1900-2200)

**Example Request:**
```bash
GET /api/v1/calendar/2025
```

**Example Response:**
```json
{
  "year": 2025,
  "movable_dates": {
    "easter": "2025-04-20",
    "ash_wednesday": "2025-03-05",
    "palm_sunday": "2025-04-13",
    "good_friday": "2025-04-18",
    "ascension": "2025-05-29",
    "pentecost": "2025-06-08",
    "trinity_sunday": "2025-06-15",
    "christ_the_king": "2025-11-23",
    "first_sunday_of_advent": "2025-11-30"
  },
  "seasons_summary": [...],
  "important_dates": {...}
}
```

## Response Fields

### Main Response Fields

| Field | Type | Description |
|-------|------|-------------|
| `date` | string | ISO 8601 date (YYYY-MM-DD) |
| `day_of_week` | string | Day name in English (Sunday, Monday, etc.) |
| `liturgical_season` | string | Current liturgical season (Advent, Christmas, Epiphany, Lent, Easter, Ordinary Time) |
| `liturgical_color` | string | Liturgical color for the day (white, red, purple, violet, rose, green, black) |
| `liturgical_year` | string | Liturgical year cycle (A, B, or C) |
| `is_sunday` | boolean | Whether the date is a Sunday |
| `is_holy_day` | boolean/null | Whether it's a principal feast or major holy day |
| `sunday_name` | string/null | Proper name for the Sunday (e.g., "1st Sunday of Advent") |
| `week_of_season` | integer/null | Week number within the current season |
| `proper_week` | integer/null | Proper number for Ordinary Time (continuous numbering) |
| `sunday_after_pentecost` | integer/null | Number of Sundays after Pentecost (if applicable) |
| `celebration` | object/null | Information about special celebrations |
| `saint` | object/null | Information about saint's day |
| `collect` | object/null | Prayer of the day |
| `readings` | object/null | Lectionary readings |

### Celebration Object

```json
{
  "id": 1,
  "name": "Easter Sunday",
  "type": "principal_feast",
  "rank": 0,
  "color": "white",
  "description": "Resurrection of our Lord",
  "transferred": false
}
```

### Saint Object

```json
{
  "name": "St. Francis of Assisi",
  "type": "lesser_feast",
  "color": "white"
}
```

### Readings Object

```json
{
  "first_reading": "Acts 10:34-43",
  "psalm": "Psalm 118:1-2, 14-24",
  "second_reading": "Colossians 3:1-4",
  "gospel": "John 20:1-18"
}
```

## Liturgical Seasons

The API recognizes six main liturgical seasons:

1. **Advent** - Preparation for Christmas (4 Sundays before December 25)
2. **Christmas** - From December 25 through January 6
3. **Epiphany** - Manifestation of Christ (January 7 to Ash Wednesday eve)
4. **Lent** - Penitential season (Ash Wednesday to Holy Saturday)
5. **Easter** - Resurrection season (Easter Sunday to Pentecost)
6. **Ordinary Time** - Regular time for spiritual growth (two periods: after Epiphany and after Pentecost)

## Liturgical Colors

| Color | Usage |
|-------|-------|
| White | Christmas, Easter, Feasts of the Lord, Non-martyr saints |
| Red | Holy Week (except Maundy Thursday), Pentecost, Martyrs |
| Purple | Lent |
| Violet | Advent |
| Rose | 3rd Sunday of Advent, 4th Sunday of Lent |
| Green | Ordinary Time |
| Black | Good Friday (optional) |

## Liturgical Year Cycles

The lectionary follows a three-year cycle for Sunday readings:

- **Year A**: Matthew-focused
- **Year B**: Mark-focused
- **Year C**: Luke-focused

The liturgical year begins on the First Sunday of Advent.

## Error Responses

### Invalid Date
```json
{
  "error": "Data inválida: Day must be between 1 and 31"
}
```
Status: `400 Bad Request`

### Out of Range Year
```json
{
  "error": "Ano inválido: Year must be between 1900 and 2200"
}
```
Status: `400 Bad Request`

## Caching

Responses are cached for 24 hours since liturgical data is static. This improves performance and reduces server load.

## Rate Limiting

(To be implemented)

## Examples

### Get Today's Liturgical Information

```javascript
// JavaScript/Node.js
const today = new Date();
const year = today.getFullYear();
const month = today.getMonth() + 1;
const day = today.getDate();

fetch(`https://api.example.com/api/v1/calendar/${year}/${month}/${day}`)
  .then(response => response.json())
  .then(data => console.log(data));
```

### Get Advent Calendar

```python
# Python
import requests

response = requests.get('https://api.example.com/api/v1/calendar/2025/12')
data = response.json()

for day in data['days']:
    if day['liturgical_season'] == 'Advent':
        print(f"{day['date']}: {day['sunday_name'] or 'Weekday in Advent'}")
```

### Find Easter Date

```bash
# cURL
curl -X GET https://api.example.com/api/v1/calendar/2025 | jq '.movable_dates.easter'
```

## Data Sources

This API uses the Anglican/Episcopal liturgical calendar based on:
- Book of Common Prayer (BCP)
- Lesser Feasts and Fasts
- Revised Common Lectionary (RCL)

## Support

For issues, feature requests, or questions, please contact the development team or file an issue on GitHub.

## License

(Add your license information here)
