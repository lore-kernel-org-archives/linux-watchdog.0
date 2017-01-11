Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:32806 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1762866AbdAKRvN (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Wed, 11 Jan 2017 12:51:13 -0500
Date: Wed, 11 Jan 2017 09:51:10 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Marc Gonzalez <marc_gonzalez@sigmadesigns.com>
Cc: Wim Van Sebroeck <wim@iguana.be>, linux-watchdog@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Mans Rullgard <mans@mansr.com>,
        Thibaud Cornic <thibaud_cornic@sigmadesigns.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Uwe Kleine-Konig <u.kleine-koenig@pengutronix.de>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 56/62] watchdog: tangox_wdt: Convert to use device
 managed functions
Message-ID: <20170111175110.GB22289@roeck-us.net>
References: <1484091325-9199-1-git-send-email-linux@roeck-us.net>
 <1484100561-17638-1-git-send-email-linux@roeck-us.net>
 <1484100561-17638-5-git-send-email-linux@roeck-us.net>
 <bd56e90c-5cb8-02d8-3518-c8f5483a6df4@sigmadesigns.com>
 <94c4d5c0-f639-eab1-6706-335977690e88@roeck-us.net>
 <a45ed205-7c1b-a298-50c0-fc8b80a846c5@sigmadesigns.com>
 <a61eb838-4167-3032-bde8-3a8845b780f8@roeck-us.net>
 <f7d9227c-4912-5c52-5ba7-ae7fa3b89857@sigmadesigns.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f7d9227c-4912-5c52-5ba7-ae7fa3b89857@sigmadesigns.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Wed, Jan 11, 2017 at 04:28:12PM +0100, Marc Gonzalez wrote:
> On 11/01/2017 15:25, Guenter Roeck wrote:
> > On 01/11/2017 04:31 AM, Marc Gonzalez wrote:
> >> On 11/01/2017 11:52, Guenter Roeck wrote:
> >>
> >>> On 01/11/2017 01:07 AM, Marc Gonzalez wrote:
> >>>
> >>>>> @@ -134,12 +134,15 @@ static int tangox_wdt_probe(struct platform_device *pdev)
> >>>>>  	err = clk_prepare_enable(dev->clk);
> >>>>>  	if (err)
> >>>>>  		return err;
> >>>>> +	err = devm_add_action_or_reset(&pdev->dev,
> >>>>> +				       (void(*)(void *))clk_disable_unprepare,
> >>>>> +				       dev->clk);
> >>>>> +	if (err)
> >>>>> +		return err;
> >>>>
> >>>> Hello Guenter,
> >>>>
> >>>> I would rather avoid the function pointer cast.
> >>>> How about defining an auxiliary function for the cleanup action?
> >>>>
> >>>> clk_disable_unprepare() is static inline, so gcc will have to
> >>>> define an auxiliary function either way. What do you think?
> >>>
> >>> Not really. It would just make it more complicated to replace the
> >>> call with devm_clk_prepare_enable(), should it ever find its way
> >>> into the light of day.
> >>
> >> More complicated, because the cleanup function will have to be deleted later?
> >> The compiler will warn if someone forgets to do that.
> >>
> >> In my opinion, it's not a good idea to rely on the fact that casting
> >> void(*)(struct clk *clk) to void(*)(void *) is likely to work as expected
> >> on most platforms. (It has undefined behavior, strictly speaking.)
> >
> > I do hear that you object to this code.
> > 
> > However, I must admit that you completely lost me here. It is a cast from
> > one function pointer to another,
> 
> Perhaps you are used to work at the assembly level, where pointers are
> just addresses, and all pointers are interchangeable.
> 
> At a slightly higher level (C abstract machine), it is not so.
> 
> > passed as argument to another function,
> > with a secondary cast of its argument from a typed pointer to a void pointer.
> > I don't think C permits for "undefined behavior, strictly speaking".
> 
> The C standard leaves quite a lot of behavior undefined, e.g.
> 
> char *foo = "hello";
> foo[1] = 'a'; // UB
> 
> char buf[4];
> *(int *)&buf = 0xdeadbeef; // UB
> 
> 1 << 64; // UB
> 
Ah, yes, I stand corrected.

However, some other unrelated undefined behavior does not mean that this
specific behavior is undefined.

So far we have a claim that a cast to a void * may somehow be different
to a cast to a different pointer, if used as function argument, and that
the behavior with such a cast may be undefined. In other words, you claim
that a function implemented as, say,

   void func(int *var) {}

might result in undefined behavior if some header file declares it as

    void func(void *);

and it is called as

    int var;

    func(&var);

That seems really far fetched to me.

I do get the message that you do not like this kind of cast. But that doesn't
mean it is not correct.

> > Besides, that same mechanism is already used elsewhere, which is how I
> > got the idea. Are you claiming that there are situations where it won't
> > work ?
> 
> If this technique is already used elsewhere in the kernel, then I'll
> crawl back under my rock (and weep).
> 

git grep "(void(\*)(void \*))"

and variants thereof:

git grep "(void(\*)"

> I can see two issues with the code you propose.
> 
> First is the same for all casts: silencing potential warnings,
> e.g. if the prototype of clk_disable_unprepare ever changed.
> (Though casts are required for vararg function arguments.)
> 
Understood. However, one should really hope that anyone changing
an API has a look at all its callers and does not just pray that
there are no problems.

> Second is just theory and not a real-world concern.
> 
> >> Do you really dislike the portable solution I suggested? :-(
> >
> > It is not more portable than the above. It is more expensive and adds more
> > code.
> 
> Maybe I am mistaken. Can you tell me why adding an auxiliary function
> is more expensive? (In CPU cycles?)
> 
In terms of code required. The idea here is to simplify the code, not
to make it more complex. The auxiliary function needs to be declared
and maintained in each affected file. I do find it easier and better
(and safer, for that matter) to let the C compiler handle it.

Guenter
