document.addEventListener('DOMContentLoaded', () => {
  console.log('DOM fully loaded and parsed');
  
  const tableBody = document.getElementById('backlinkTableBody');
  const rows = Array.from(tableBody.querySelectorAll('tr'));

  // Sorting functionality
  document.querySelectorAll('.sortable').forEach(header => {
    header.addEventListener('click', () => {
      console.log(`Sorting by ${header.dataset.sort}`);
      const sortAttribute = header.dataset.sort;
      const sortedRows = rows.sort((a, b) => {
        const aValue = a.querySelector(`td:nth-child(${header.cellIndex + 1})`).textContent.trim();
        const bValue = b.querySelector(`td:nth-child(${header.cellIndex + 1})`).textContent.trim();
        
        if (sortAttribute === 'price' || sortAttribute === 'traffic' || sortAttribute === 'domain_rank') {
          return parseFloat(aValue) - parseFloat(bValue);
        } else if (sortAttribute === 'added_on') {
          return new Date(aValue) - new Date(bValue);
        } else {
          return aValue.localeCompare(bValue);
        }
      });

      // Re-append rows to the table in sorted order
      sortedRows.forEach(row => tableBody.appendChild(row));
    });
  });

  // Reset button functionality
  document.getElementById('reset-btn').addEventListener('click', function() {
    const form = document.getElementById('filter-form');
    
    // Reset all form fields
    form.reset();

    // Explicitly clear radio button selections
    document.querySelectorAll('input[type="radio"]').forEach(radio => {
      radio.checked = false;
    });

    // Update the table to show all rows after resetting
    rows.forEach(row => {
      row.style.display = '';
    });
  });

  // Filtering functionality
  document.querySelectorAll('.filter-input, .filter-radio').forEach(input => {
    input.addEventListener('change', () => {
      console.log(`Filter changed on ${input.name}`);
      filterTable();
    });
  });

  function filterTable() {
    const filters = {
      country: document.querySelector('select[name="country"]').value.toLowerCase(),
      category: document.querySelector('select[name="category"]').value.toLowerCase(),
      max_price: parseInt(document.querySelector('input[name="max_price"]').value) || null,
      min_price: parseInt(document.querySelector('input[name="min_price"]').value) || null,
      article_writing: document.querySelector('input[name="article_writing"]:checked') ? document.querySelector('input[name="article_writing"]:checked').value.toLowerCase() : null,
      cs_possible: document.querySelector('input[name="cs_possible"]:checked') ? document.querySelector('input[name="cs_possible"]:checked').value.toLowerCase() : null,
      special_price: document.querySelector('input[name="special_price"]:checked') ? document.querySelector('input[name="special_price"]:checked').value.toLowerCase() : null
    };

    rows.forEach(row => {
      const country = row.querySelector('td:nth-child(2)').textContent.toLowerCase();
      const category = row.querySelector('td:nth-child(7)').textContent.toLowerCase();
      const price = parseInt(row.querySelector('td:nth-child(4)').textContent);
      const articleWriting = row.querySelector('td:nth-child(9)').textContent.toLowerCase();
      const csPossible = row.querySelector('td:nth-child(10)').textContent.toLowerCase();
      const specialPrice = row.querySelector('td:nth-child(11)').textContent.toLowerCase();

      let showRow = true;

      if (filters.country && country !== filters.country) {
        showRow = false;
      }
      if (filters.category && category !== filters.category) {
        showRow = false;
      }
      if (filters.min_price && price < filters.min_price) {
        showRow = false;
      }
      if (filters.max_price && price > filters.max_price) {
        showRow = false;
      }
      if (filters.article_writing && articleWriting !== filters.article_writing) {
        showRow = false;
      }
      if (filters.cs_possible && csPossible !== filters.cs_possible) {
        showRow = false;
      }
      if (filters.special_price && specialPrice !== filters.special_price) {
        showRow = false;
      }

      console.log(`Row visibility for ${row.querySelector('td:nth-child(3)').textContent}: ${showRow}`);
      row.style.display = showRow ? '' : 'none';
    });
  }
});