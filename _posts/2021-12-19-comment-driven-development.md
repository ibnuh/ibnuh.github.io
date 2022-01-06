---
layout: post
title: 'Comment driven development'
date: 2021-12-19 07:52:00 +0700
topics:
---

I tend to sketch out the stages or pseudo-code everything using comments whether I'm coding a large or complicated usecase or something where things could quickly spiral out of hand. Of course, we're talking about coding simple usecases here, not system design and architecture, for which you'll need a lot more than comments.

When a buddy of mine realized what I was doing, he informed me that what I was doing was called Comment Driven Development. That's when I discovered that "Comment First" is a practice known as Comment Driven Development or Comment Programming, in which you think through the task and write down the phases in the form of code comments, then start translating those comments into actual code after everything is clear.

You might even be doing the same thing without realizing it since you have CDD. Allow me to illustrate it with an example of how I go about creating something, or in other words, what Comment Driven Development is.

> Disclaimer: Do not take this seriously. Ignore the existence of any such thing as OOP. Ignore the SOLID principles entirely. Allow the architect inside you to rest for a while and use this example solely to grasp Comment Driven Development.

```c#
// Purchase a book

// Check book availability
// Check user balance
// Deduct user balance
// Add payment information
// Add book to library
// Generate email body
// Send purchase confirmation to email
```

As you can see, the steps to purchase a book are now apparent, and we can move on to converting it to actual code, which I might change to something like this.

```c#
// Purchase a book
public async Task PurchaseBook(Book book)
{
    // Check book availability
    var isAvailable = _bookService.IsAvailable(book);
    if (!isAvailable)
    {
        throw new Exception($"{book.Title} is currently unavailable");
    }

    // Check user balance
    var isBalanceAvailable = _userService.HasEnoughBalanceToPurchase(book.Price);
    if (!isBalanceAvailable)
    {
        throw new Exception("You don't have enough balance");
    }

    // Deduct user balance
    _userService.ReduceBalance(book.Price);

    // Add payment information
    var payment = _paymentService.AddHistory(new Payment {
        Status = PaymentStatus.Paid,
        Amount = book.Price
    });

    // Add book to library
    _libraryService.Add(new Library {
        Book = book,
        Payment = payment
    });

    // Generate email body
    var emailBody = _emailRenderService.Render(EmailTemplate.PurchaseConfirmation, payment);

    // Send purchase confirmation to email
    _emailQueueService.Add(new EmailQueue {
        Recipient = _userService.GetEmail(),
        Subject = "Thank you for your purchase",
        Body = emailBody,
    });

    await _dbContext.SaveChanges();
}
```

Now that we have the code ready, we can start eliminating any comments that are no longer needed.

Also, please note that I have only used a single `method` for demonstration purposes; I do not intend to promote the procedural approach to programming, nor am I suggesting that you create a single method/function and stuff it with everything, or that you ignore SOLID design principles and Design Patterns. Also, I'm not advocating that you should rely solely on these inline remarks without first considering the application's design. It's up to you to figure out how you want to organize things and what works best for your application. CDD, in my opinion, is useful when coding specific inner usecases of the program where certain sub-steps are involved, such as `PurchaseBook`, where additional steps must be performed with it.

For me, the aim of CDD is to simply understand and list down the steps needed in a usecase, and then when I've written the functionality and am entirely comfortable with the functionality and architecture that I've laid out, I delete any extraneous comments.

That's all there is to it when it comes to Comment Driven Development. Now, here's why I use this method and why you should, too:

-   It allows me to double-check that everything is obvious to me before I begin coding, which helps me to stay on track.
-   You can use this method to diagram the stages and possibly instruct someone on the functionality you want them to develop.
-   Documentation, although it only provides a high level but it might seem makes sense for some cases.

That's all there is to it. Do you have any more suggestions? What's the best way to code something? I'd love to hear from you, contact me on twitter [@ibnuhx](https://twitter.com/ibnuhx){:target="\_blank"}.
