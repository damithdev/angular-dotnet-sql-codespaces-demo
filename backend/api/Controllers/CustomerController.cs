using Microsoft.AspNetCore.Mvc;

namespace api.Controllers;

[ApiController]
[Route("api/[controller]")]
public class CustomerController : ControllerBase
{
    private static readonly List<Customer> Customers = new()
    {
        new Customer { Id = 1, Name = "Alice" },
        new Customer { Id = 2, Name = "Bob" }
    };

    [HttpGet]
    public ActionResult<IEnumerable<Customer>> GetAll() => Ok(Customers);

    [HttpPost]
    public ActionResult Add([FromBody] Customer customer)
    {
        Customers.Add(customer);
        return Ok(customer);
    }
}

public class Customer
{
    public int Id { get; set; }
    public string? Name { get; set; }
}