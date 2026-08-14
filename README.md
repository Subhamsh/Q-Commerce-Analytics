# Q-Commerce-Analytics

Analysis of Indian Quick Commerce order, delivery, customer, and dark-store data to identify revenue drivers and operational insights.

## Summary

This project analyzes Quick Commerce order, delivery, customer, and dark-store data from an Indian Q-Commerce business environment. The goal is to identify revenue drivers, customer purchasing patterns, operational inefficiencies, and opportunities to improve overall business performance.

## Business Context

Quick Commerce (Q-Commerce) companies such as Blinkit, Zepto, and Swiggy Instamart aim to deliver products to customers within minutes. To achieve this, they operate multiple dark stores (small fulfilment centers) across different locations. While fast delivery improves customer experience, it also increases operational costs such as inventory management, warehousing, staffing, and last-mile delivery.

To remain profitable, companies must optimize Average Order Value (AOV), improve delivery efficiency, reduce cancellations, and ensure that each dark store operates effectively.

## Business Problem

The company wants to understand how customer purchasing behavior, delivery performance, discount strategies, and dark-store operations impact revenue and profitability.

Management needs answers to the following questions:

- Which product categories generate the highest sales?
- Which dark stores have the highest cancellation rates?
- What are the most common cancellation reasons?
- Which dark stores perform best and worst?
- Which cities experience the most failed orders?
- How does customer spending vary across locations?
- Which product categories contribute most to revenue?
- How can Average Order Value (AOV) be improved?
- Do discounts increase order value?
- Which categories depend most on discounts?
- Do repeat customers spend more than new customers?
- Which customer segment contributes most revenue?

## Project Objective

The objective of this project is to analyze Quick Commerce operational data to identify revenue opportunities, customer behavior patterns, cancellation drivers, delivery performance issues, and dark-store performance differences.

The analysis will help management:

1. Understand customer purchasing behavior.
2. Optimize dark store performance.
3. Increase Average Order Value (AOV).
4. Improve overall business profitability.

## Key Metrics

- **AOV (Average Order Value):** Total Revenue / Total Number of Orders
- **Total Revenue:** Sum of final order amount
- **Average Delivery Time (in minutes):** Total Delivery Time / Total Delivered Orders
- **Cancellation Rate:** Cancelled Orders / Total Orders
- **Average Customer Rating:** Total Rating Score / Number of Rated Orders
- **Discount Utilization Rate:** Orders with Discounts / Total Orders

## Dataset Overview

**Source:** [India Q-Commerce Orders Dataset (2015–2025)](https://www.kaggle.com/datasets/shubhampatil75/india-q-commerce-orders-dataset-2015-2025)

- **Year Used Initially:** 2015
- **Number of Columns:** 27
- **Data Note:** The dataset was synthetically generated and may not represent actual production data from any Quick Commerce company.

### Key Fields

- Order ID
- City
- Category
- Dark Store ID
- Order Amount
- Discount
- Final Amount
- Delivery Fee
- Delivery Time
- Payment Mode
- Order Status
- Customer Rating
- Customer Lifetime Orders

## Tools Used

- Excel
- PostgreSQL
- Power BI
- GitHub
