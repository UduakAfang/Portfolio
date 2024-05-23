{
    "metadata": {
        "kernelspec": {
            "name": "SQL",
            "display_name": "SQL",
            "language": "sql"
        },
        "language_info": {
            "name": "sql",
            "version": ""
        }
    },
    "nbformat_minor": 2,
    "nbformat": 4,
    "cells": [
        {
            "cell_type": "markdown",
            "source": [
                "# **\\------    High Level Sales Analysis**"
            ],
            "metadata": {
                "azdata_cell_guid": "538cf83e-0091-46e7-9676-5518279e68e6"
            },
            "attachments": {}
        },
        {
            "cell_type": "markdown",
            "source": [
                "### \n",
                "\n",
                "- **What was the total quantity sold for all products?**"
            ],
            "metadata": {
                "azdata_cell_guid": "fdfcddcd-f28f-4f01-a3c2-718ac8bdb8df"
            },
            "attachments": {}
        },
        {
            "cell_type": "code",
            "source": [
                "SELECT SUM(qty) total_qty\n",
                "FROM sales;"
            ],
            "metadata": {
                "azdata_cell_guid": "60452337-aab7-43ec-a111-123fbe6a2438",
                "language": "sql"
            },
            "outputs": [
                {
                    "output_type": "display_data",
                    "data": {
                        "text/html": "(1 row affected)"
                    },
                    "metadata": {}
                },
                {
                    "output_type": "display_data",
                    "data": {
                        "text/html": "Total execution time: 00:00:00.210"
                    },
                    "metadata": {}
                },
                {
                    "output_type": "execute_result",
                    "metadata": {},
                    "execution_count": 28,
                    "data": {
                        "application/vnd.dataresource+json": {
                            "schema": {
                                "fields": [
                                    {
                                        "name": "total_qty"
                                    }
                                ]
                            },
                            "data": [
                                {
                                    "total_qty": "45216"
                                }
                            ]
                        },
                        "text/html": [
                            "<table>",
                            "<tr><th>total_qty</th></tr>",
                            "<tr><td>45216</td></tr>",
                            "</table>"
                        ]
                    }
                }
            ],
            "execution_count": 28
        },
        {
            "cell_type": "code",
            "source": [
                "-- each product\n",
                "SELECT pd.product_name, SUM(qty) total_quantity_sold\n",
                "FROM sales s\n",
                "JOIN product_details pd ON s.prod_id = pd.product_id \n",
                "GROUP BY pd.product_name\n",
                "ORDER BY 2 DESC;"
            ],
            "metadata": {
                "language": "sql",
                "azdata_cell_guid": "25997c46-a2b0-4dd8-98c1-a9d8bd9df9c3"
            },
            "outputs": [
                {
                    "output_type": "display_data",
                    "data": {
                        "text/html": "(12 rows affected)"
                    },
                    "metadata": {}
                },
                {
                    "output_type": "display_data",
                    "data": {
                        "text/html": "Total execution time: 00:00:03.042"
                    },
                    "metadata": {}
                },
                {
                    "output_type": "execute_result",
                    "metadata": {},
                    "execution_count": 29,
                    "data": {
                        "application/vnd.dataresource+json": {
                            "schema": {
                                "fields": [
                                    {
                                        "name": "product_name"
                                    },
                                    {
                                        "name": "total_quantity_sold"
                                    }
                                ]
                            },
                            "data": [
                                {
                                    "product_name": "Grey Fashion Jacket - Womens",
                                    "total_quantity_sold": "3876"
                                },
                                {
                                    "product_name": "Navy Oversized Jeans - Womens",
                                    "total_quantity_sold": "3856"
                                },
                                {
                                    "product_name": "Blue Polo Shirt - Mens",
                                    "total_quantity_sold": "3819"
                                },
                                {
                                    "product_name": "White Tee Shirt - Mens",
                                    "total_quantity_sold": "3800"
                                },
                                {
                                    "product_name": "Navy Solid Socks - Mens",
                                    "total_quantity_sold": "3792"
                                },
                                {
                                    "product_name": "Black Straight Jeans - Womens",
                                    "total_quantity_sold": "3786"
                                },
                                {
                                    "product_name": "Pink Fluro Polkadot Socks - Mens",
                                    "total_quantity_sold": "3770"
                                },
                                {
                                    "product_name": "Indigo Rain Jacket - Womens",
                                    "total_quantity_sold": "3757"
                                },
                                {
                                    "product_name": "Khaki Suit Jacket - Womens",
                                    "total_quantity_sold": "3752"
                                },
                                {
                                    "product_name": "Cream Relaxed Jeans - Womens",
                                    "total_quantity_sold": "3707"
                                },
                                {
                                    "product_name": "White Striped Socks - Mens",
                                    "total_quantity_sold": "3655"
                                },
                                {
                                    "product_name": "Teal Button Up Shirt - Mens",
                                    "total_quantity_sold": "3646"
                                }
                            ]
                        },
                        "text/html": [
                            "<table>",
                            "<tr><th>product_name</th><th>total_quantity_sold</th></tr>",
                            "<tr><td>Grey Fashion Jacket - Womens</td><td>3876</td></tr>",
                            "<tr><td>Navy Oversized Jeans - Womens</td><td>3856</td></tr>",
                            "<tr><td>Blue Polo Shirt - Mens</td><td>3819</td></tr>",
                            "<tr><td>White Tee Shirt - Mens</td><td>3800</td></tr>",
                            "<tr><td>Navy Solid Socks - Mens</td><td>3792</td></tr>",
                            "<tr><td>Black Straight Jeans - Womens</td><td>3786</td></tr>",
                            "<tr><td>Pink Fluro Polkadot Socks - Mens</td><td>3770</td></tr>",
                            "<tr><td>Indigo Rain Jacket - Womens</td><td>3757</td></tr>",
                            "<tr><td>Khaki Suit Jacket - Womens</td><td>3752</td></tr>",
                            "<tr><td>Cream Relaxed Jeans - Womens</td><td>3707</td></tr>",
                            "<tr><td>White Striped Socks - Mens</td><td>3655</td></tr>",
                            "<tr><td>Teal Button Up Shirt - Mens</td><td>3646</td></tr>",
                            "</table>"
                        ]
                    }
                }
            ],
            "execution_count": 29
        },
        {
            "cell_type": "markdown",
            "source": [
                "- **What is the total generated revenue for all products before discounts?**"
            ],
            "metadata": {
                "language": "",
                "azdata_cell_guid": "7711d170-99cb-4d3f-9fab-be5e383d872b"
            },
            "attachments": {}
        },
        {
            "cell_type": "code",
            "source": [
                "SELECT SUM(price * qty) revenue\n",
                "FROM sales;"
            ],
            "metadata": {
                "language": "sql",
                "azdata_cell_guid": "360df258-e9d0-4079-a4e2-106f690d9b46"
            },
            "outputs": [
                {
                    "output_type": "display_data",
                    "data": {
                        "text/html": "(1 row affected)"
                    },
                    "metadata": {}
                },
                {
                    "output_type": "display_data",
                    "data": {
                        "text/html": "Total execution time: 00:00:00.020"
                    },
                    "metadata": {}
                },
                {
                    "output_type": "execute_result",
                    "metadata": {},
                    "execution_count": 30,
                    "data": {
                        "application/vnd.dataresource+json": {
                            "schema": {
                                "fields": [
                                    {
                                        "name": "revenue"
                                    }
                                ]
                            },
                            "data": [
                                {
                                    "revenue": "1289453"
                                }
                            ]
                        },
                        "text/html": [
                            "<table>",
                            "<tr><th>revenue</th></tr>",
                            "<tr><td>1289453</td></tr>",
                            "</table>"
                        ]
                    }
                }
            ],
            "execution_count": 30
        },
        {
            "cell_type": "code",
            "source": [
                "-- each product\n",
                "SELECT pd.product_name, SUM(s.price * qty) total_revenue\n",
                "FROM sales s\n",
                "JOIN product_details pd ON s.prod_id = pd.product_id \n",
                "GROUP BY pd.product_name\n",
                "ORDER BY 2 DESC;"
            ],
            "metadata": {
                "language": "sql",
                "azdata_cell_guid": "3f789281-5ca2-41d9-a084-0a088da900f4"
            },
            "outputs": [
                {
                    "output_type": "display_data",
                    "data": {
                        "text/html": "(12 rows affected)"
                    },
                    "metadata": {}
                },
                {
                    "output_type": "display_data",
                    "data": {
                        "text/html": "Total execution time: 00:00:00.516"
                    },
                    "metadata": {}
                },
                {
                    "output_type": "execute_result",
                    "metadata": {},
                    "execution_count": 31,
                    "data": {
                        "application/vnd.dataresource+json": {
                            "schema": {
                                "fields": [
                                    {
                                        "name": "product_name"
                                    },
                                    {
                                        "name": "total_revenue"
                                    }
                                ]
                            },
                            "data": [
                                {
                                    "product_name": "Blue Polo Shirt - Mens",
                                    "total_revenue": "217683"
                                },
                                {
                                    "product_name": "Grey Fashion Jacket - Womens",
                                    "total_revenue": "209304"
                                },
                                {
                                    "product_name": "White Tee Shirt - Mens",
                                    "total_revenue": "152000"
                                },
                                {
                                    "product_name": "Navy Solid Socks - Mens",
                                    "total_revenue": "136512"
                                },
                                {
                                    "product_name": "Black Straight Jeans - Womens",
                                    "total_revenue": "121152"
                                },
                                {
                                    "product_name": "Pink Fluro Polkadot Socks - Mens",
                                    "total_revenue": "109330"
                                },
                                {
                                    "product_name": "Khaki Suit Jacket - Womens",
                                    "total_revenue": "86296"
                                },
                                {
                                    "product_name": "Indigo Rain Jacket - Womens",
                                    "total_revenue": "71383"
                                },
                                {
                                    "product_name": "White Striped Socks - Mens",
                                    "total_revenue": "62135"
                                },
                                {
                                    "product_name": "Navy Oversized Jeans - Womens",
                                    "total_revenue": "50128"
                                },
                                {
                                    "product_name": "Cream Relaxed Jeans - Womens",
                                    "total_revenue": "37070"
                                },
                                {
                                    "product_name": "Teal Button Up Shirt - Mens",
                                    "total_revenue": "36460"
                                }
                            ]
                        },
                        "text/html": [
                            "<table>",
                            "<tr><th>product_name</th><th>total_revenue</th></tr>",
                            "<tr><td>Blue Polo Shirt - Mens</td><td>217683</td></tr>",
                            "<tr><td>Grey Fashion Jacket - Womens</td><td>209304</td></tr>",
                            "<tr><td>White Tee Shirt - Mens</td><td>152000</td></tr>",
                            "<tr><td>Navy Solid Socks - Mens</td><td>136512</td></tr>",
                            "<tr><td>Black Straight Jeans - Womens</td><td>121152</td></tr>",
                            "<tr><td>Pink Fluro Polkadot Socks - Mens</td><td>109330</td></tr>",
                            "<tr><td>Khaki Suit Jacket - Womens</td><td>86296</td></tr>",
                            "<tr><td>Indigo Rain Jacket - Womens</td><td>71383</td></tr>",
                            "<tr><td>White Striped Socks - Mens</td><td>62135</td></tr>",
                            "<tr><td>Navy Oversized Jeans - Womens</td><td>50128</td></tr>",
                            "<tr><td>Cream Relaxed Jeans - Womens</td><td>37070</td></tr>",
                            "<tr><td>Teal Button Up Shirt - Mens</td><td>36460</td></tr>",
                            "</table>"
                        ]
                    }
                }
            ],
            "execution_count": 31
        },
        {
            "cell_type": "markdown",
            "source": [
                "- <span style=\"color: #000000;\"><b>What was the total discount amount for all products?</b></span>"
            ],
            "metadata": {
                "azdata_cell_guid": "ac01d95b-fc88-4a1f-b8cf-a8be727e24ae"
            },
            "attachments": {}
        },
        {
            "cell_type": "code",
            "source": [
                "SELECT CAST(SUM(qty * price * discount/100.0) AS FLOAT) AS total_discount\n",
                "FROM sales;"
            ],
            "metadata": {
                "language": "sql",
                "azdata_cell_guid": "bec9f87c-54ee-4eaa-9ba4-b5d5ba131ceb"
            },
            "outputs": [
                {
                    "output_type": "display_data",
                    "data": {
                        "text/html": "(1 row affected)"
                    },
                    "metadata": {}
                },
                {
                    "output_type": "display_data",
                    "data": {
                        "text/html": "Total execution time: 00:00:00.018"
                    },
                    "metadata": {}
                },
                {
                    "output_type": "execute_result",
                    "metadata": {},
                    "execution_count": 32,
                    "data": {
                        "application/vnd.dataresource+json": {
                            "schema": {
                                "fields": [
                                    {
                                        "name": "total_discount"
                                    }
                                ]
                            },
                            "data": [
                                {
                                    "total_discount": "156229.14"
                                }
                            ]
                        },
                        "text/html": [
                            "<table>",
                            "<tr><th>total_discount</th></tr>",
                            "<tr><td>156229.14</td></tr>",
                            "</table>"
                        ]
                    }
                }
            ],
            "execution_count": 32
        },
        {
            "cell_type": "code",
            "source": [
                "-- each product\n",
                "SELECT pd.product_name, CAST(SUM(qty * s.price * discount/100.0) AS FLOAT) AS total_discount\n",
                "FROM sales s\n",
                "JOIN product_details pd ON s.prod_id = pd.product_id \n",
                "GROUP BY pd.product_name\n",
                "ORDER BY 2 DESC;"
            ],
            "metadata": {
                "language": "sql",
                "azdata_cell_guid": "021f0e35-5b28-42d2-8ecf-70f0d69c3676"
            },
            "outputs": [
                {
                    "output_type": "display_data",
                    "data": {
                        "text/html": "(12 rows affected)"
                    },
                    "metadata": {}
                },
                {
                    "output_type": "display_data",
                    "data": {
                        "text/html": "Total execution time: 00:00:00.221"
                    },
                    "metadata": {}
                },
                {
                    "output_type": "execute_result",
                    "metadata": {},
                    "execution_count": 33,
                    "data": {
                        "application/vnd.dataresource+json": {
                            "schema": {
                                "fields": [
                                    {
                                        "name": "product_name"
                                    },
                                    {
                                        "name": "total_discount"
                                    }
                                ]
                            },
                            "data": [
                                {
                                    "product_name": "Blue Polo Shirt - Mens",
                                    "total_discount": "26819.07"
                                },
                                {
                                    "product_name": "Grey Fashion Jacket - Womens",
                                    "total_discount": "25391.88"
                                },
                                {
                                    "product_name": "White Tee Shirt - Mens",
                                    "total_discount": "18377.6"
                                },
                                {
                                    "product_name": "Navy Solid Socks - Mens",
                                    "total_discount": "16650.36"
                                },
                                {
                                    "product_name": "Black Straight Jeans - Womens",
                                    "total_discount": "14744.96"
                                },
                                {
                                    "product_name": "Pink Fluro Polkadot Socks - Mens",
                                    "total_discount": "12952.27"
                                },
                                {
                                    "product_name": "Khaki Suit Jacket - Womens",
                                    "total_discount": "10243.05"
                                },
                                {
                                    "product_name": "Indigo Rain Jacket - Womens",
                                    "total_discount": "8642.53"
                                },
                                {
                                    "product_name": "White Striped Socks - Mens",
                                    "total_discount": "7410.81"
                                },
                                {
                                    "product_name": "Navy Oversized Jeans - Womens",
                                    "total_discount": "6135.61"
                                },
                                {
                                    "product_name": "Cream Relaxed Jeans - Womens",
                                    "total_discount": "4463.4"
                                },
                                {
                                    "product_name": "Teal Button Up Shirt - Mens",
                                    "total_discount": "4397.6"
                                }
                            ]
                        },
                        "text/html": [
                            "<table>",
                            "<tr><th>product_name</th><th>total_discount</th></tr>",
                            "<tr><td>Blue Polo Shirt - Mens</td><td>26819.07</td></tr>",
                            "<tr><td>Grey Fashion Jacket - Womens</td><td>25391.88</td></tr>",
                            "<tr><td>White Tee Shirt - Mens</td><td>18377.6</td></tr>",
                            "<tr><td>Navy Solid Socks - Mens</td><td>16650.36</td></tr>",
                            "<tr><td>Black Straight Jeans - Womens</td><td>14744.96</td></tr>",
                            "<tr><td>Pink Fluro Polkadot Socks - Mens</td><td>12952.27</td></tr>",
                            "<tr><td>Khaki Suit Jacket - Womens</td><td>10243.05</td></tr>",
                            "<tr><td>Indigo Rain Jacket - Womens</td><td>8642.53</td></tr>",
                            "<tr><td>White Striped Socks - Mens</td><td>7410.81</td></tr>",
                            "<tr><td>Navy Oversized Jeans - Womens</td><td>6135.61</td></tr>",
                            "<tr><td>Cream Relaxed Jeans - Womens</td><td>4463.4</td></tr>",
                            "<tr><td>Teal Button Up Shirt - Mens</td><td>4397.6</td></tr>",
                            "</table>"
                        ]
                    }
                }
            ],
            "execution_count": 33
        },
        {
            "cell_type": "markdown",
            "source": [
                "# <span style=\"color: #000000;\"><b>-------&nbsp; Transaction Analysis</b></span>"
            ],
            "metadata": {
                "azdata_cell_guid": "bcab1cc9-6e20-41e8-a094-2a4f46def29a"
            },
            "attachments": {}
        },
        {
            "cell_type": "markdown",
            "source": [
                "<span style=\"color: #000000;\"><b>How many unique transactions were there?</b></span>"
            ],
            "metadata": {
                "azdata_cell_guid": "1eb7a37e-719b-437f-b507-aeff81e4f80f"
            },
            "attachments": {}
        },
        {
            "cell_type": "code",
            "source": [
                "SELECT COUNT(DISTINCT txn_id)\n",
                "FROM sales;"
            ],
            "metadata": {
                "language": "sql",
                "azdata_cell_guid": "341fe373-5902-40bf-99a8-0eee67585210",
                "tags": []
            },
            "outputs": [
                {
                    "output_type": "display_data",
                    "data": {
                        "text/html": "(1 row affected)"
                    },
                    "metadata": {}
                },
                {
                    "output_type": "display_data",
                    "data": {
                        "text/html": "Total execution time: 00:00:00.524"
                    },
                    "metadata": {}
                },
                {
                    "output_type": "execute_result",
                    "metadata": {},
                    "execution_count": 34,
                    "data": {
                        "application/vnd.dataresource+json": {
                            "schema": {
                                "fields": [
                                    {
                                        "name": "(No column name)"
                                    }
                                ]
                            },
                            "data": [
                                {
                                    "(No column name)": "2500"
                                }
                            ]
                        },
                        "text/html": [
                            "<table>",
                            "<tr><th>(No column name)</th></tr>",
                            "<tr><td>2500</td></tr>",
                            "</table>"
                        ]
                    }
                }
            ],
            "execution_count": 34
        },
        {
            "cell_type": "markdown",
            "source": [
                "**What is the average unique products purchased in each transaction?**"
            ],
            "metadata": {
                "language": "",
                "azdata_cell_guid": "79004616-c132-45bb-b32b-27690ee43a19"
            },
            "attachments": {}
        },
        {
            "cell_type": "code",
            "source": [
                "SELECT AVG(sub.product_count)\n",
                "FROM \n",
                "    (\n",
                "    SELECT COUNT(DISTINCT prod_id) product_count\n",
                "    FROM sales\n",
                "    GROUP BY txn_id\n",
                "    ) sub\n",
                ";"
            ],
            "metadata": {
                "language": "sql",
                "azdata_cell_guid": "f69ef227-c01d-4989-992f-d5e3b1b3c6a5"
            },
            "outputs": [
                {
                    "output_type": "display_data",
                    "data": {
                        "text/html": "(1 row affected)"
                    },
                    "metadata": {}
                },
                {
                    "output_type": "display_data",
                    "data": {
                        "text/html": "Total execution time: 00:00:00.029"
                    },
                    "metadata": {}
                },
                {
                    "output_type": "execute_result",
                    "metadata": {},
                    "execution_count": 35,
                    "data": {
                        "application/vnd.dataresource+json": {
                            "schema": {
                                "fields": [
                                    {
                                        "name": "(No column name)"
                                    }
                                ]
                            },
                            "data": [
                                {
                                    "(No column name)": "6"
                                }
                            ]
                        },
                        "text/html": [
                            "<table>",
                            "<tr><th>(No column name)</th></tr>",
                            "<tr><td>6</td></tr>",
                            "</table>"
                        ]
                    }
                }
            ],
            "execution_count": 35
        },
        {
            "cell_type": "markdown",
            "source": [
                "**What are the 25th, 50th and 75th percentile values for the revenue per transaction?**"
            ],
            "metadata": {
                "language": "",
                "azdata_cell_guid": "2ddf477c-a782-4df3-8e81-052573021c61"
            },
            "attachments": {}
        },
        {
            "cell_type": "code",
            "source": [
                "WITH revenue AS\n",
                "(\n",
                "    SELECT txn_id, SUM(price * qty) revenue\n",
                "    FROM sales\n",
                "    GROUP BY txn_id\n",
                ")\n",
                "SELECT DISTINCT\n",
                "    PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY revenue) OVER () as \"25th Percentile\",\n",
                "    PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY revenue) OVER () as \"50th Percentile\",\n",
                "    PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY revenue) OVER () as \"75th Percentile\"\n",
                "FROM revenue;"
            ],
            "metadata": {
                "language": "sql",
                "azdata_cell_guid": "cf3fe805-d27f-4ae5-8beb-189f969c636a"
            },
            "outputs": [
                {
                    "output_type": "display_data",
                    "data": {
                        "text/html": "(1 row affected)"
                    },
                    "metadata": {}
                },
                {
                    "output_type": "display_data",
                    "data": {
                        "text/html": "Total execution time: 00:00:00.219"
                    },
                    "metadata": {}
                },
                {
                    "output_type": "execute_result",
                    "metadata": {},
                    "execution_count": 36,
                    "data": {
                        "application/vnd.dataresource+json": {
                            "schema": {
                                "fields": [
                                    {
                                        "name": "25th Percentile"
                                    },
                                    {
                                        "name": "50th Percentile"
                                    },
                                    {
                                        "name": "75th Percentile"
                                    }
                                ]
                            },
                            "data": [
                                {
                                    "25th Percentile": "375.75",
                                    "50th Percentile": "509.5",
                                    "75th Percentile": "647"
                                }
                            ]
                        },
                        "text/html": [
                            "<table>",
                            "<tr><th>25th Percentile</th><th>50th Percentile</th><th>75th Percentile</th></tr>",
                            "<tr><td>375.75</td><td>509.5</td><td>647</td></tr>",
                            "</table>"
                        ]
                    }
                }
            ],
            "execution_count": 36
        },
        {
            "cell_type": "markdown",
            "source": [
                "**What is the average discount value per transaction?**"
            ],
            "metadata": {
                "language": "",
                "azdata_cell_guid": "cbf62a34-b1a8-419c-8b76-35a1025728fa"
            },
            "attachments": {}
        },
        {
            "cell_type": "code",
            "source": [
                "\n",
                "SELECT AVG(sub.trans_disc)\n",
                "FROM\n",
                "    ( \n",
                "        SELECT txn_id, CAST (SUM(price * qty * discount/100.0) as decimal(5,1)) as trans_disc\n",
                "        FROM sales\n",
                "        GROUP BY txn_id\n",
                "    )sub"
            ],
            "metadata": {
                "language": "sql",
                "azdata_cell_guid": "a8962c88-a843-4277-849c-2c3500e22e00"
            },
            "outputs": [
                {
                    "output_type": "display_data",
                    "data": {
                        "text/html": "(1 row affected)"
                    },
                    "metadata": {}
                },
                {
                    "output_type": "display_data",
                    "data": {
                        "text/html": "Total execution time: 00:00:00.507"
                    },
                    "metadata": {}
                },
                {
                    "output_type": "execute_result",
                    "metadata": {},
                    "execution_count": 37,
                    "data": {
                        "application/vnd.dataresource+json": {
                            "schema": {
                                "fields": [
                                    {
                                        "name": "(No column name)"
                                    }
                                ]
                            },
                            "data": [
                                {
                                    "(No column name)": "62.496080"
                                }
                            ]
                        },
                        "text/html": [
                            "<table>",
                            "<tr><th>(No column name)</th></tr>",
                            "<tr><td>62.496080</td></tr>",
                            "</table>"
                        ]
                    }
                }
            ],
            "execution_count": 37
        },
        {
            "cell_type": "markdown",
            "source": [
                "**What is the percentage split of all transactions for members vs non-members?**"
            ],
            "metadata": {
                "language": "",
                "azdata_cell_guid": "4831ddc8-6173-4541-84be-580ab49dc275"
            },
            "attachments": {}
        },
        {
            "cell_type": "code",
            "source": [
                "\n",
                "SELECT \n",
                "    CAST (100.0 * COUNT(DISTINCT CASE WHEN member = 't' THEN txn_id END)\n",
                "     / COUNT(DISTINCT txn_id) AS float) AS member_transaction_percentage,\n",
                "    CAST (100.0 * COUNT(DISTINCT CASE WHEN member = 'f' THEN txn_id END) \n",
                "    / COUNT(DISTINCT txn_id) AS float) AS nonmember_transaction_percentage\n",
                "FROM sales;"
            ],
            "metadata": {
                "language": "sql",
                "azdata_cell_guid": "59742b73-9d75-4ad0-896c-e2b2ae9bbdce",
                "tags": []
            },
            "outputs": [
                {
                    "output_type": "display_data",
                    "data": {
                        "text/html": "Warning: Null value is eliminated by an aggregate or other SET operation."
                    },
                    "metadata": {}
                },
                {
                    "output_type": "display_data",
                    "data": {
                        "text/html": "(1 row affected)"
                    },
                    "metadata": {}
                },
                {
                    "output_type": "display_data",
                    "data": {
                        "text/html": "Total execution time: 00:00:00.134"
                    },
                    "metadata": {}
                },
                {
                    "output_type": "execute_result",
                    "metadata": {},
                    "execution_count": 38,
                    "data": {
                        "application/vnd.dataresource+json": {
                            "schema": {
                                "fields": [
                                    {
                                        "name": "member_transaction_percentage"
                                    },
                                    {
                                        "name": "nonmember_transaction_percentage"
                                    }
                                ]
                            },
                            "data": [
                                {
                                    "member_transaction_percentage": "60.2",
                                    "nonmember_transaction_percentage": "39.8"
                                }
                            ]
                        },
                        "text/html": [
                            "<table>",
                            "<tr><th>member_transaction_percentage</th><th>nonmember_transaction_percentage</th></tr>",
                            "<tr><td>60.2</td><td>39.8</td></tr>",
                            "</table>"
                        ]
                    }
                }
            ],
            "execution_count": 38
        },
        {
            "cell_type": "markdown",
            "source": [
                "**What is the average revenue for member transactions and non-member transactions?**"
            ],
            "metadata": {
                "language": "",
                "azdata_cell_guid": "1f6d6d8a-3694-4bf9-8e43-f0727d2a4ac2"
            },
            "attachments": {}
        },
        {
            "cell_type": "code",
            "source": [
                "\n",
                "with revenue AS\n",
                "    (\n",
                "        SELECT txn_id, member, CAST (SUM(price * qty * 1.0) AS float) revenue\n",
                "        FROM sales\n",
                "        GROUP BY member, txn_id\n",
                "    )\n",
                "SELECT member,CAST( AVG(revenue) AS decimal(5,2)) avg_revenue\n",
                "FROM revenue\n",
                "GROUP BY member;"
            ],
            "metadata": {
                "language": "sql",
                "azdata_cell_guid": "b4064ac0-39ab-4ca7-bb59-934dfd467ab0"
            },
            "outputs": [
                {
                    "output_type": "display_data",
                    "data": {
                        "text/html": "(2 rows affected)"
                    },
                    "metadata": {}
                },
                {
                    "output_type": "display_data",
                    "data": {
                        "text/html": "Total execution time: 00:00:00.299"
                    },
                    "metadata": {}
                },
                {
                    "output_type": "execute_result",
                    "metadata": {},
                    "execution_count": 39,
                    "data": {
                        "application/vnd.dataresource+json": {
                            "schema": {
                                "fields": [
                                    {
                                        "name": "member"
                                    },
                                    {
                                        "name": "avg_revenue"
                                    }
                                ]
                            },
                            "data": [
                                {
                                    "member": "f",
                                    "avg_revenue": "515.04"
                                },
                                {
                                    "member": "t",
                                    "avg_revenue": "516.27"
                                }
                            ]
                        },
                        "text/html": [
                            "<table>",
                            "<tr><th>member</th><th>avg_revenue</th></tr>",
                            "<tr><td>f</td><td>515.04</td></tr>",
                            "<tr><td>t</td><td>516.27</td></tr>",
                            "</table>"
                        ]
                    }
                }
            ],
            "execution_count": 39
        },
        {
            "cell_type": "markdown",
            "source": [
                "**What are the top 3 products by total revenue before discount?**"
            ],
            "metadata": {
                "language": "",
                "azdata_cell_guid": "1bd1a4d9-cc7f-4eaf-bdfe-ffdc1c44cf45"
            },
            "attachments": {}
        },
        {
            "cell_type": "code",
            "source": [
                "\n",
                "SELECT TOP 3 pd.product_name, SUM(s.qty * s.price) revenue\n",
                "FROM sales s\n",
                "JOIN [product_details] pd on pd.product_id = s.prod_id\n",
                "GROUP BY pd.product_name\n",
                "ORDER BY 2 DESC;"
            ],
            "metadata": {
                "language": "sql",
                "azdata_cell_guid": "a8841573-23ff-4b59-aaa6-bc3a952a4176",
                "tags": []
            },
            "outputs": [
                {
                    "output_type": "display_data",
                    "data": {
                        "text/html": "(3 rows affected)"
                    },
                    "metadata": {}
                },
                {
                    "output_type": "display_data",
                    "data": {
                        "text/html": "Total execution time: 00:00:01.692"
                    },
                    "metadata": {}
                },
                {
                    "output_type": "execute_result",
                    "metadata": {},
                    "execution_count": 40,
                    "data": {
                        "application/vnd.dataresource+json": {
                            "schema": {
                                "fields": [
                                    {
                                        "name": "product_name"
                                    },
                                    {
                                        "name": "revenue"
                                    }
                                ]
                            },
                            "data": [
                                {
                                    "product_name": "Blue Polo Shirt - Mens",
                                    "revenue": "217683"
                                },
                                {
                                    "product_name": "Grey Fashion Jacket - Womens",
                                    "revenue": "209304"
                                },
                                {
                                    "product_name": "White Tee Shirt - Mens",
                                    "revenue": "152000"
                                }
                            ]
                        },
                        "text/html": [
                            "<table>",
                            "<tr><th>product_name</th><th>revenue</th></tr>",
                            "<tr><td>Blue Polo Shirt - Mens</td><td>217683</td></tr>",
                            "<tr><td>Grey Fashion Jacket - Womens</td><td>209304</td></tr>",
                            "<tr><td>White Tee Shirt - Mens</td><td>152000</td></tr>",
                            "</table>"
                        ]
                    }
                }
            ],
            "execution_count": 40
        },
        {
            "cell_type": "markdown",
            "source": [
                "**What is the total quantity, revenue and discount for each segment?**"
            ],
            "metadata": {
                "language": "",
                "azdata_cell_guid": "a140b6f7-eb90-49f2-a416-fdd92e589fbc"
            },
            "attachments": {}
        },
        {
            "cell_type": "code",
            "source": [
                "SELECT segment_name, SUM(s.qty * s.price) revenue, \n",
                "        SUM(s.qty) quantity,\n",
                "        CAST(SUM(s.qty * s.price * s.discount/100.0) as float) discount\n",
                "FROM sales s\n",
                "JOIN [product_details] pd on pd.product_id = s.prod_id\n",
                "GROUP BY pd.segment_name;"
            ],
            "metadata": {
                "language": "sql",
                "azdata_cell_guid": "b594ead1-384f-43c9-8241-a0d7714741e6"
            },
            "outputs": [
                {
                    "output_type": "display_data",
                    "data": {
                        "text/html": "(4 rows affected)"
                    },
                    "metadata": {}
                },
                {
                    "output_type": "display_data",
                    "data": {
                        "text/html": "Total execution time: 00:00:00.029"
                    },
                    "metadata": {}
                },
                {
                    "output_type": "execute_result",
                    "metadata": {},
                    "execution_count": 41,
                    "data": {
                        "application/vnd.dataresource+json": {
                            "schema": {
                                "fields": [
                                    {
                                        "name": "segment_name"
                                    },
                                    {
                                        "name": "revenue"
                                    },
                                    {
                                        "name": "quantity"
                                    },
                                    {
                                        "name": "discount"
                                    }
                                ]
                            },
                            "data": [
                                {
                                    "segment_name": "Jacket",
                                    "revenue": "366983",
                                    "quantity": "11385",
                                    "discount": "44277.46"
                                },
                                {
                                    "segment_name": "Jeans",
                                    "revenue": "208350",
                                    "quantity": "11349",
                                    "discount": "25343.97"
                                },
                                {
                                    "segment_name": "Shirt",
                                    "revenue": "406143",
                                    "quantity": "11265",
                                    "discount": "49594.27"
                                },
                                {
                                    "segment_name": "Socks",
                                    "revenue": "307977",
                                    "quantity": "11217",
                                    "discount": "37013.44"
                                }
                            ]
                        },
                        "text/html": [
                            "<table>",
                            "<tr><th>segment_name</th><th>revenue</th><th>quantity</th><th>discount</th></tr>",
                            "<tr><td>Jacket</td><td>366983</td><td>11385</td><td>44277.46</td></tr>",
                            "<tr><td>Jeans</td><td>208350</td><td>11349</td><td>25343.97</td></tr>",
                            "<tr><td>Shirt</td><td>406143</td><td>11265</td><td>49594.27</td></tr>",
                            "<tr><td>Socks</td><td>307977</td><td>11217</td><td>37013.44</td></tr>",
                            "</table>"
                        ]
                    }
                }
            ],
            "execution_count": 41
        },
        {
            "cell_type": "markdown",
            "source": [
                "**What is the top selling product for each segment?**"
            ],
            "metadata": {
                "language": "",
                "azdata_cell_guid": "c7583b48-7d91-4a19-a5f5-8ad8766c5e1b"
            },
            "attachments": {}
        },
        {
            "cell_type": "code",
            "source": [
                "SELECT segment_name,sub.product_name, total_qty_sold,rank\n",
                "FROM\n",
                "    (\n",
                "        SELECT product_name, pd.segment_name, SUM(s.qty) total_qty_sold,\n",
                "        ROW_NUMBER () OVER (PARTITION BY pd.segment_name ORDER BY SUM(s.qty) DESC ) rank\n",
                "        FROM sales s\n",
                "        JOIN [product_details] pd on pd.product_id = s.prod_id\n",
                "        GROUP BY segment_name, product_name\n",
                "    ) sub\n",
                "WHERE sub.rank = 1\n",
                "ORDER BY segment_name,sub.rank;"
            ],
            "metadata": {
                "language": "sql",
                "azdata_cell_guid": "89d8084d-d195-4173-b7b5-e10e1a7d0624"
            },
            "outputs": [
                {
                    "output_type": "display_data",
                    "data": {
                        "text/html": "(4 rows affected)"
                    },
                    "metadata": {}
                },
                {
                    "output_type": "display_data",
                    "data": {
                        "text/html": "Total execution time: 00:00:00.251"
                    },
                    "metadata": {}
                },
                {
                    "output_type": "execute_result",
                    "metadata": {},
                    "execution_count": 42,
                    "data": {
                        "application/vnd.dataresource+json": {
                            "schema": {
                                "fields": [
                                    {
                                        "name": "segment_name"
                                    },
                                    {
                                        "name": "product_name"
                                    },
                                    {
                                        "name": "total_qty_sold"
                                    },
                                    {
                                        "name": "rank"
                                    }
                                ]
                            },
                            "data": [
                                {
                                    "segment_name": "Jacket",
                                    "product_name": "Grey Fashion Jacket - Womens",
                                    "total_qty_sold": "3876",
                                    "rank": "1"
                                },
                                {
                                    "segment_name": "Jeans",
                                    "product_name": "Navy Oversized Jeans - Womens",
                                    "total_qty_sold": "3856",
                                    "rank": "1"
                                },
                                {
                                    "segment_name": "Shirt",
                                    "product_name": "Blue Polo Shirt - Mens",
                                    "total_qty_sold": "3819",
                                    "rank": "1"
                                },
                                {
                                    "segment_name": "Socks",
                                    "product_name": "Navy Solid Socks - Mens",
                                    "total_qty_sold": "3792",
                                    "rank": "1"
                                }
                            ]
                        },
                        "text/html": [
                            "<table>",
                            "<tr><th>segment_name</th><th>product_name</th><th>total_qty_sold</th><th>rank</th></tr>",
                            "<tr><td>Jacket</td><td>Grey Fashion Jacket - Womens</td><td>3876</td><td>1</td></tr>",
                            "<tr><td>Jeans</td><td>Navy Oversized Jeans - Womens</td><td>3856</td><td>1</td></tr>",
                            "<tr><td>Shirt</td><td>Blue Polo Shirt - Mens</td><td>3819</td><td>1</td></tr>",
                            "<tr><td>Socks</td><td>Navy Solid Socks - Mens</td><td>3792</td><td>1</td></tr>",
                            "</table>"
                        ]
                    }
                }
            ],
            "execution_count": 42
        },
        {
            "cell_type": "markdown",
            "source": [
                "**What is the total quantity, revenue and discount for each category?**"
            ],
            "metadata": {
                "language": "",
                "azdata_cell_guid": "56594944-0a04-48fe-a47a-b3a5ca31ad8e",
                "tags": []
            },
            "attachments": {}
        },
        {
            "cell_type": "code",
            "source": [
                "SELECT category_name,\n",
                "         SUM(s.qty) quantity,\n",
                "         SUM(s.qty * s.price) revenue, \n",
                "         CAST(SUM(s.qty * s.price * s.discount/100.0) as float) discount\n",
                "FROM sales s\n",
                "JOIN [product_details] pd on pd.product_id = s.prod_id\n",
                "GROUP BY pd.category_name;"
            ],
            "metadata": {
                "language": "sql",
                "azdata_cell_guid": "e63a4441-fa63-455c-9c52-10364ed5ccb7",
                "tags": []
            },
            "outputs": [
                {
                    "output_type": "display_data",
                    "data": {
                        "text/html": "(2 rows affected)"
                    },
                    "metadata": {}
                },
                {
                    "output_type": "display_data",
                    "data": {
                        "text/html": "Total execution time: 00:00:00.517"
                    },
                    "metadata": {}
                },
                {
                    "output_type": "execute_result",
                    "metadata": {},
                    "execution_count": 43,
                    "data": {
                        "application/vnd.dataresource+json": {
                            "schema": {
                                "fields": [
                                    {
                                        "name": "category_name"
                                    },
                                    {
                                        "name": "quantity"
                                    },
                                    {
                                        "name": "revenue"
                                    },
                                    {
                                        "name": "discount"
                                    }
                                ]
                            },
                            "data": [
                                {
                                    "category_name": "Mens",
                                    "quantity": "22482",
                                    "revenue": "714120",
                                    "discount": "86607.71"
                                },
                                {
                                    "category_name": "Womens",
                                    "quantity": "22734",
                                    "revenue": "575333",
                                    "discount": "69621.43"
                                }
                            ]
                        },
                        "text/html": [
                            "<table>",
                            "<tr><th>category_name</th><th>quantity</th><th>revenue</th><th>discount</th></tr>",
                            "<tr><td>Mens</td><td>22482</td><td>714120</td><td>86607.71</td></tr>",
                            "<tr><td>Womens</td><td>22734</td><td>575333</td><td>69621.43</td></tr>",
                            "</table>"
                        ]
                    }
                }
            ],
            "execution_count": 43
        },
        {
            "cell_type": "markdown",
            "source": [
                "**What is the top selling product for each category?**"
            ],
            "metadata": {
                "language": "",
                "azdata_cell_guid": "c047a0d0-1c38-4a92-826b-f95026bd9b34"
            },
            "attachments": {}
        },
        {
            "cell_type": "code",
            "source": [
                "\n",
                "SELECT category_name,sub.product_name, total_qty_sold\n",
                "FROM\n",
                "    (\n",
                "        SELECT product_name, pd.category_name, SUM(s.qty) total_qty_sold,\n",
                "        ROW_NUMBER () OVER (PARTITION BY category_name ORDER BY SUM(s.qty) DESC ) rank\n",
                "        FROM sales s\n",
                "        JOIN [product_details] pd on pd.product_id = s.prod_id\n",
                "        GROUP BY category_name, product_name\n",
                "    ) sub\n",
                "WHERE sub.rank = 1\n",
                "ORDER BY category_name,sub.rank ASC;"
            ],
            "metadata": {
                "language": "sql",
                "azdata_cell_guid": "1c1694a2-602d-4032-926e-164e9902e24a"
            },
            "outputs": [
                {
                    "output_type": "display_data",
                    "data": {
                        "text/html": "(2 rows affected)"
                    },
                    "metadata": {}
                },
                {
                    "output_type": "display_data",
                    "data": {
                        "text/html": "Total execution time: 00:00:00.016"
                    },
                    "metadata": {}
                },
                {
                    "output_type": "execute_result",
                    "metadata": {},
                    "execution_count": 44,
                    "data": {
                        "application/vnd.dataresource+json": {
                            "schema": {
                                "fields": [
                                    {
                                        "name": "category_name"
                                    },
                                    {
                                        "name": "product_name"
                                    },
                                    {
                                        "name": "total_qty_sold"
                                    }
                                ]
                            },
                            "data": [
                                {
                                    "category_name": "Mens",
                                    "product_name": "Blue Polo Shirt - Mens",
                                    "total_qty_sold": "3819"
                                },
                                {
                                    "category_name": "Womens",
                                    "product_name": "Grey Fashion Jacket - Womens",
                                    "total_qty_sold": "3876"
                                }
                            ]
                        },
                        "text/html": [
                            "<table>",
                            "<tr><th>category_name</th><th>product_name</th><th>total_qty_sold</th></tr>",
                            "<tr><td>Mens</td><td>Blue Polo Shirt - Mens</td><td>3819</td></tr>",
                            "<tr><td>Womens</td><td>Grey Fashion Jacket - Womens</td><td>3876</td></tr>",
                            "</table>"
                        ]
                    }
                }
            ],
            "execution_count": 44
        },
        {
            "cell_type": "markdown",
            "source": [
                "**What is the percentage split of revenue by product for each segment?**"
            ],
            "metadata": {
                "language": "",
                "azdata_cell_guid": "94c0bbb8-d8e5-4be1-b366-1972ab335882"
            },
            "attachments": {}
        },
        {
            "cell_type": "code",
            "source": [
                "WITH revenue AS (\n",
                "    SELECT \n",
                "        pd.segment_name,\n",
                "        pd.product_name,\n",
                "        SUM(s.price * qty) AS total_revenue\n",
                "    FROM sales s\n",
                "    JOIN [product_details] pd on pd.product_id = s.prod_id\n",
                "    GROUP BY product_name, segment_name\n",
                ")\n",
                "SELECT \n",
                "    segment_name,\n",
                "    product_name,\n",
                "    total_revenue,\n",
                "    100.0 * total_revenue / SUM(total_revenue) OVER (PARTITION BY segment_name) AS percentage_of_segment\n",
                "FROM revenue;"
            ],
            "metadata": {
                "language": "sql",
                "azdata_cell_guid": "23410ea0-1cf1-424b-9c5a-4ea97d22e4a8"
            },
            "outputs": [
                {
                    "output_type": "display_data",
                    "data": {
                        "text/html": "(12 rows affected)"
                    },
                    "metadata": {}
                },
                {
                    "output_type": "display_data",
                    "data": {
                        "text/html": "Total execution time: 00:00:00.221"
                    },
                    "metadata": {}
                },
                {
                    "output_type": "execute_result",
                    "metadata": {},
                    "execution_count": 45,
                    "data": {
                        "application/vnd.dataresource+json": {
                            "schema": {
                                "fields": [
                                    {
                                        "name": "segment_name"
                                    },
                                    {
                                        "name": "product_name"
                                    },
                                    {
                                        "name": "total_revenue"
                                    },
                                    {
                                        "name": "percentage_of_segment"
                                    }
                                ]
                            },
                            "data": [
                                {
                                    "segment_name": "Jacket",
                                    "product_name": "Grey Fashion Jacket - Womens",
                                    "total_revenue": "209304",
                                    "percentage_of_segment": "57.033704558521"
                                },
                                {
                                    "segment_name": "Jacket",
                                    "product_name": "Indigo Rain Jacket - Womens",
                                    "total_revenue": "71383",
                                    "percentage_of_segment": "19.451309733693"
                                },
                                {
                                    "segment_name": "Jacket",
                                    "product_name": "Khaki Suit Jacket - Womens",
                                    "total_revenue": "86296",
                                    "percentage_of_segment": "23.514985707784"
                                },
                                {
                                    "segment_name": "Jeans",
                                    "product_name": "Black Straight Jeans - Womens",
                                    "total_revenue": "121152",
                                    "percentage_of_segment": "58.148308135349"
                                },
                                {
                                    "segment_name": "Jeans",
                                    "product_name": "Cream Relaxed Jeans - Womens",
                                    "total_revenue": "37070",
                                    "percentage_of_segment": "17.792176625869"
                                },
                                {
                                    "segment_name": "Jeans",
                                    "product_name": "Navy Oversized Jeans - Womens",
                                    "total_revenue": "50128",
                                    "percentage_of_segment": "24.059515238780"
                                },
                                {
                                    "segment_name": "Shirt",
                                    "product_name": "Blue Polo Shirt - Mens",
                                    "total_revenue": "217683",
                                    "percentage_of_segment": "53.597624482017"
                                },
                                {
                                    "segment_name": "Shirt",
                                    "product_name": "Teal Button Up Shirt - Mens",
                                    "total_revenue": "36460",
                                    "percentage_of_segment": "8.977133669668"
                                },
                                {
                                    "segment_name": "Shirt",
                                    "product_name": "White Tee Shirt - Mens",
                                    "total_revenue": "152000",
                                    "percentage_of_segment": "37.425241848314"
                                },
                                {
                                    "segment_name": "Socks",
                                    "product_name": "Navy Solid Socks - Mens",
                                    "total_revenue": "136512",
                                    "percentage_of_segment": "44.325387934813"
                                },
                                {
                                    "segment_name": "Socks",
                                    "product_name": "Pink Fluro Polkadot Socks - Mens",
                                    "total_revenue": "109330",
                                    "percentage_of_segment": "35.499404176285"
                                },
                                {
                                    "segment_name": "Socks",
                                    "product_name": "White Striped Socks - Mens",
                                    "total_revenue": "62135",
                                    "percentage_of_segment": "20.175207888900"
                                }
                            ]
                        },
                        "text/html": [
                            "<table>",
                            "<tr><th>segment_name</th><th>product_name</th><th>total_revenue</th><th>percentage_of_segment</th></tr>",
                            "<tr><td>Jacket</td><td>Grey Fashion Jacket - Womens</td><td>209304</td><td>57.033704558521</td></tr>",
                            "<tr><td>Jacket</td><td>Indigo Rain Jacket - Womens</td><td>71383</td><td>19.451309733693</td></tr>",
                            "<tr><td>Jacket</td><td>Khaki Suit Jacket - Womens</td><td>86296</td><td>23.514985707784</td></tr>",
                            "<tr><td>Jeans</td><td>Black Straight Jeans - Womens</td><td>121152</td><td>58.148308135349</td></tr>",
                            "<tr><td>Jeans</td><td>Cream Relaxed Jeans - Womens</td><td>37070</td><td>17.792176625869</td></tr>",
                            "<tr><td>Jeans</td><td>Navy Oversized Jeans - Womens</td><td>50128</td><td>24.059515238780</td></tr>",
                            "<tr><td>Shirt</td><td>Blue Polo Shirt - Mens</td><td>217683</td><td>53.597624482017</td></tr>",
                            "<tr><td>Shirt</td><td>Teal Button Up Shirt - Mens</td><td>36460</td><td>8.977133669668</td></tr>",
                            "<tr><td>Shirt</td><td>White Tee Shirt - Mens</td><td>152000</td><td>37.425241848314</td></tr>",
                            "<tr><td>Socks</td><td>Navy Solid Socks - Mens</td><td>136512</td><td>44.325387934813</td></tr>",
                            "<tr><td>Socks</td><td>Pink Fluro Polkadot Socks - Mens</td><td>109330</td><td>35.499404176285</td></tr>",
                            "<tr><td>Socks</td><td>White Striped Socks - Mens</td><td>62135</td><td>20.175207888900</td></tr>",
                            "</table>"
                        ]
                    }
                }
            ],
            "execution_count": 45
        },
        {
            "cell_type": "markdown",
            "source": [
                "**What is the percentage split of revenue by segment for each category?**"
            ],
            "metadata": {
                "language": "",
                "azdata_cell_guid": "7eaa0920-5e80-4b96-9da9-6bc7d14803bb"
            },
            "attachments": {}
        },
        {
            "cell_type": "code",
            "source": [
                "WITH revenue AS (\n",
                "    SELECT \n",
                "        pd.category_name,\n",
                "        pd.segment_name,\n",
                "        SUM(s.price * qty) AS total_revenue\n",
                "    FROM sales s\n",
                "    JOIN [product_details] pd on pd.product_id = s.prod_id\n",
                "    GROUP BY category_name, segment_name\n",
                ")\n",
                "SELECT \n",
                "    category_name,\n",
                "    segment_name,\n",
                "    total_revenue,\n",
                "    100.0 * total_revenue \n",
                "    / \n",
                "    SUM(total_revenue) OVER (PARTITION BY category_name) AS percentage_of_category\n",
                "FROM revenue;"
            ],
            "metadata": {
                "language": "sql",
                "azdata_cell_guid": "d349ff86-d3c8-43a0-8060-7f4f623596bf"
            },
            "outputs": [
                {
                    "output_type": "display_data",
                    "data": {
                        "text/html": "(4 rows affected)"
                    },
                    "metadata": {}
                },
                {
                    "output_type": "display_data",
                    "data": {
                        "text/html": "Total execution time: 00:00:01.020"
                    },
                    "metadata": {}
                },
                {
                    "output_type": "execute_result",
                    "metadata": {},
                    "execution_count": 46,
                    "data": {
                        "application/vnd.dataresource+json": {
                            "schema": {
                                "fields": [
                                    {
                                        "name": "category_name"
                                    },
                                    {
                                        "name": "segment_name"
                                    },
                                    {
                                        "name": "total_revenue"
                                    },
                                    {
                                        "name": "percentage_of_category"
                                    }
                                ]
                            },
                            "data": [
                                {
                                    "category_name": "Mens",
                                    "segment_name": "Shirt",
                                    "total_revenue": "406143",
                                    "percentage_of_category": "56.873214585783"
                                },
                                {
                                    "category_name": "Mens",
                                    "segment_name": "Socks",
                                    "total_revenue": "307977",
                                    "percentage_of_category": "43.126785414216"
                                },
                                {
                                    "category_name": "Womens",
                                    "segment_name": "Jacket",
                                    "total_revenue": "366983",
                                    "percentage_of_category": "63.786189910886"
                                },
                                {
                                    "category_name": "Womens",
                                    "segment_name": "Jeans",
                                    "total_revenue": "208350",
                                    "percentage_of_category": "36.213810089113"
                                }
                            ]
                        },
                        "text/html": [
                            "<table>",
                            "<tr><th>category_name</th><th>segment_name</th><th>total_revenue</th><th>percentage_of_category</th></tr>",
                            "<tr><td>Mens</td><td>Shirt</td><td>406143</td><td>56.873214585783</td></tr>",
                            "<tr><td>Mens</td><td>Socks</td><td>307977</td><td>43.126785414216</td></tr>",
                            "<tr><td>Womens</td><td>Jacket</td><td>366983</td><td>63.786189910886</td></tr>",
                            "<tr><td>Womens</td><td>Jeans</td><td>208350</td><td>36.213810089113</td></tr>",
                            "</table>"
                        ]
                    }
                }
            ],
            "execution_count": 46
        },
        {
            "cell_type": "markdown",
            "source": [
                "**What is the percentage split of total revenue by category?**"
            ],
            "metadata": {
                "language": "",
                "azdata_cell_guid": "fac552f6-b643-4669-96d5-65cfaea7947c"
            },
            "attachments": {}
        },
        {
            "cell_type": "code",
            "source": [
                "WITH category_revenue AS (\n",
                "    SELECT \n",
                "        pd.category_name,\n",
                "        SUM(s.price * s.qty) AS total_revenue\n",
                "    FROM sales s\n",
                "    INNER JOIN product_details pd ON s.prod_id = pd.product_id\n",
                "    GROUP BY category_name\n",
                ")\n",
                "SELECT \n",
                "    category_name,\n",
                "    total_revenue,\n",
                "    100.0 * total_revenue / SUM(total_revenue) OVER () AS percentage_of_total_revenue\n",
                "FROM category_revenue;"
            ],
            "metadata": {
                "language": "sql",
                "azdata_cell_guid": "d150cc35-2a34-4824-9fa3-64842c8c2ba9"
            },
            "outputs": [
                {
                    "output_type": "display_data",
                    "data": {
                        "text/html": "(2 rows affected)"
                    },
                    "metadata": {}
                },
                {
                    "output_type": "display_data",
                    "data": {
                        "text/html": "Total execution time: 00:00:00.020"
                    },
                    "metadata": {}
                },
                {
                    "output_type": "execute_result",
                    "metadata": {},
                    "execution_count": 47,
                    "data": {
                        "application/vnd.dataresource+json": {
                            "schema": {
                                "fields": [
                                    {
                                        "name": "category_name"
                                    },
                                    {
                                        "name": "total_revenue"
                                    },
                                    {
                                        "name": "percentage_of_total_revenue"
                                    }
                                ]
                            },
                            "data": [
                                {
                                    "category_name": "Mens",
                                    "total_revenue": "714120",
                                    "percentage_of_total_revenue": "55.381623060320"
                                },
                                {
                                    "category_name": "Womens",
                                    "total_revenue": "575333",
                                    "percentage_of_total_revenue": "44.618376939679"
                                }
                            ]
                        },
                        "text/html": [
                            "<table>",
                            "<tr><th>category_name</th><th>total_revenue</th><th>percentage_of_total_revenue</th></tr>",
                            "<tr><td>Mens</td><td>714120</td><td>55.381623060320</td></tr>",
                            "<tr><td>Womens</td><td>575333</td><td>44.618376939679</td></tr>",
                            "</table>"
                        ]
                    }
                }
            ],
            "execution_count": 47
        },
        {
            "cell_type": "markdown",
            "source": [
                "**What is the total transaction “penetration” for each product? hint: penetration = number of transactions where at least 1 quantity of  a product was purchased divided by total number of transactions)**"
            ],
            "metadata": {
                "language": "",
                "azdata_cell_guid": "2548833e-8f80-4abf-aef3-42a2f135c0ad"
            },
            "attachments": {}
        },
        {
            "cell_type": "code",
            "source": [
                "WITH TransactionCounts AS (\n",
                "  SELECT\n",
                "    prod_id,\n",
                "    COUNT(DISTINCT txn_id) AS transaction_count\n",
                "  FROM\n",
                "    sales\n",
                "  WHERE\n",
                "    qty > 0\n",
                "  GROUP BY\n",
                "    prod_id\n",
                "),\n",
                "TotalTransactions AS (\n",
                "  SELECT\n",
                "    COUNT(DISTINCT txn_id) AS total_transactions\n",
                "  FROM\n",
                "    sales\n",
                ")\n",
                "SELECT\n",
                "  product_name,\n",
                "  tc.transaction_count,\n",
                "  CAST(100.0 *  tc.transaction_count AS FLOAT) / tt.total_transactions AS penetration\n",
                "FROM\n",
                "  TransactionCounts tc\n",
                "  CROSS JOIN TotalTransactions tt\n",
                "      JOIN product_details PD ON TC.prod_id = PD.product_id"
            ],
            "metadata": {
                "language": "sql",
                "azdata_cell_guid": "7c656458-0c8f-4929-beb8-7115df1675d9"
            },
            "outputs": [
                {
                    "output_type": "display_data",
                    "data": {
                        "text/html": "(12 rows affected)"
                    },
                    "metadata": {}
                },
                {
                    "output_type": "display_data",
                    "data": {
                        "text/html": "Total execution time: 00:00:00.224"
                    },
                    "metadata": {}
                },
                {
                    "output_type": "execute_result",
                    "metadata": {},
                    "execution_count": 48,
                    "data": {
                        "application/vnd.dataresource+json": {
                            "schema": {
                                "fields": [
                                    {
                                        "name": "product_name"
                                    },
                                    {
                                        "name": "transaction_count"
                                    },
                                    {
                                        "name": "penetration"
                                    }
                                ]
                            },
                            "data": [
                                {
                                    "product_name": "Navy Oversized Jeans - Womens",
                                    "transaction_count": "1274",
                                    "penetration": "50.96"
                                },
                                {
                                    "product_name": "Black Straight Jeans - Womens",
                                    "transaction_count": "1246",
                                    "penetration": "49.84"
                                },
                                {
                                    "product_name": "Cream Relaxed Jeans - Womens",
                                    "transaction_count": "1243",
                                    "penetration": "49.72"
                                },
                                {
                                    "product_name": "Khaki Suit Jacket - Womens",
                                    "transaction_count": "1247",
                                    "penetration": "49.88"
                                },
                                {
                                    "product_name": "Indigo Rain Jacket - Womens",
                                    "transaction_count": "1250",
                                    "penetration": "50"
                                },
                                {
                                    "product_name": "Grey Fashion Jacket - Womens",
                                    "transaction_count": "1275",
                                    "penetration": "51"
                                },
                                {
                                    "product_name": "White Tee Shirt - Mens",
                                    "transaction_count": "1268",
                                    "penetration": "50.72"
                                },
                                {
                                    "product_name": "Teal Button Up Shirt - Mens",
                                    "transaction_count": "1242",
                                    "penetration": "49.68"
                                },
                                {
                                    "product_name": "Blue Polo Shirt - Mens",
                                    "transaction_count": "1268",
                                    "penetration": "50.72"
                                },
                                {
                                    "product_name": "Navy Solid Socks - Mens",
                                    "transaction_count": "1281",
                                    "penetration": "51.24"
                                },
                                {
                                    "product_name": "White Striped Socks - Mens",
                                    "transaction_count": "1243",
                                    "penetration": "49.72"
                                },
                                {
                                    "product_name": "Pink Fluro Polkadot Socks - Mens",
                                    "transaction_count": "1258",
                                    "penetration": "50.32"
                                }
                            ]
                        },
                        "text/html": [
                            "<table>",
                            "<tr><th>product_name</th><th>transaction_count</th><th>penetration</th></tr>",
                            "<tr><td>Navy Oversized Jeans - Womens</td><td>1274</td><td>50.96</td></tr>",
                            "<tr><td>Black Straight Jeans - Womens</td><td>1246</td><td>49.84</td></tr>",
                            "<tr><td>Cream Relaxed Jeans - Womens</td><td>1243</td><td>49.72</td></tr>",
                            "<tr><td>Khaki Suit Jacket - Womens</td><td>1247</td><td>49.88</td></tr>",
                            "<tr><td>Indigo Rain Jacket - Womens</td><td>1250</td><td>50</td></tr>",
                            "<tr><td>Grey Fashion Jacket - Womens</td><td>1275</td><td>51</td></tr>",
                            "<tr><td>White Tee Shirt - Mens</td><td>1268</td><td>50.72</td></tr>",
                            "<tr><td>Teal Button Up Shirt - Mens</td><td>1242</td><td>49.68</td></tr>",
                            "<tr><td>Blue Polo Shirt - Mens</td><td>1268</td><td>50.72</td></tr>",
                            "<tr><td>Navy Solid Socks - Mens</td><td>1281</td><td>51.24</td></tr>",
                            "<tr><td>White Striped Socks - Mens</td><td>1243</td><td>49.72</td></tr>",
                            "<tr><td>Pink Fluro Polkadot Socks - Mens</td><td>1258</td><td>50.32</td></tr>",
                            "</table>"
                        ]
                    }
                }
            ],
            "execution_count": 48
        },
        {
            "cell_type": "markdown",
            "source": [
                "**What is the most common combination of at least 1 quantity of any 3 products in a 1 single transaction?**"
            ],
            "metadata": {
                "language": "",
                "azdata_cell_guid": "303e9a1e-8c05-49e3-840c-1533ec0a0e2a"
            },
            "attachments": {}
        },
        {
            "cell_type": "code",
            "source": [
                "\n",
                "WITH TransactionProducts AS (\n",
                "  SELECT\n",
                "    txn_id,\n",
                "    prod_id,\n",
                "    product_name\n",
                "  FROM\n",
                "    sales\n",
                "    JOIN product_details ON sales.prod_id = product_details.product_id\n",
                "  WHERE\n",
                "    qty > 0\n",
                "),\n",
                "TransactionCombinations AS (\n",
                "  SELECT\n",
                "    tp1.txn_id,\n",
                "    tp1.product_name AS product1,\n",
                "    tp2.product_name AS product2,\n",
                "    tp3.product_name AS product3\n",
                "  FROM\n",
                "    TransactionProducts tp1\n",
                "  JOIN\n",
                "    TransactionProducts tp2 ON tp1.txn_id = tp2.txn_id AND tp1.prod_id < tp2.prod_id\n",
                "  JOIN\n",
                "    TransactionProducts tp3 ON tp1.txn_id = tp3.txn_id AND tp2.prod_id < tp3.prod_id\n",
                ")\n",
                "SELECT TOP 1\n",
                "  product1,\n",
                "  product2,\n",
                "  product3,\n",
                "  COUNT(*) AS combination_count\n",
                "FROM\n",
                "  TransactionCombinations\n",
                "GROUP BY\n",
                "  product1,\n",
                "  product2,\n",
                "  product3\n",
                "ORDER BY\n",
                "  combination_count DESC;"
            ],
            "metadata": {
                "language": "sql",
                "azdata_cell_guid": "7b84798e-f8b3-4b30-b9dd-6762361e31a4"
            },
            "outputs": [
                {
                    "output_type": "display_data",
                    "data": {
                        "text/html": "(1 row affected)"
                    },
                    "metadata": {}
                },
                {
                    "output_type": "display_data",
                    "data": {
                        "text/html": "Total execution time: 00:00:01.007"
                    },
                    "metadata": {}
                },
                {
                    "output_type": "execute_result",
                    "metadata": {},
                    "execution_count": 49,
                    "data": {
                        "application/vnd.dataresource+json": {
                            "schema": {
                                "fields": [
                                    {
                                        "name": "product1"
                                    },
                                    {
                                        "name": "product2"
                                    },
                                    {
                                        "name": "product3"
                                    },
                                    {
                                        "name": "combination_count"
                                    }
                                ]
                            },
                            "data": [
                                {
                                    "product1": "White Tee Shirt - Mens",
                                    "product2": "Grey Fashion Jacket - Womens",
                                    "product3": "Teal Button Up Shirt - Mens",
                                    "combination_count": "352"
                                }
                            ]
                        },
                        "text/html": [
                            "<table>",
                            "<tr><th>product1</th><th>product2</th><th>product3</th><th>combination_count</th></tr>",
                            "<tr><td>White Tee Shirt - Mens</td><td>Grey Fashion Jacket - Womens</td><td>Teal Button Up Shirt - Mens</td><td>352</td></tr>",
                            "</table>"
                        ]
                    }
                }
            ],
            "execution_count": 49
        }
    ]
}