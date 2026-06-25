package com.xyzbank.cardsystem.repository;

import com.xyzbank.cardsystem.entity.Customer;
import org.springframework.data.jpa.repository.JpaRepository;

public interface CustomerRepository
        extends JpaRepository<Customer, Long> {
}
