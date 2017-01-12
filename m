Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:49321 "EHLO
        metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750864AbdALJ6B (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Thu, 12 Jan 2017 04:58:01 -0500
Date: Thu, 12 Jan 2017 10:57:57 +0100
From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
        <u.kleine-koenig@pengutronix.de>
To: Marc Gonzalez <marc_gonzalez@sigmadesigns.com>
Cc: Guenter Roeck <linux@roeck-us.net>,
        Wim Van Sebroeck <wim@iguana.be>,
        linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Mans Rullgard <mans@mansr.com>,
        Thibaud Cornic <thibaud_cornic@sigmadesigns.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 56/62] watchdog: tangox_wdt: Convert to use device
 managed functions
Message-ID: <20170112095757.xjszyir27gs2ribj@pengutronix.de>
References: <1484091325-9199-1-git-send-email-linux@roeck-us.net>
 <1484100561-17638-1-git-send-email-linux@roeck-us.net>
 <1484100561-17638-5-git-send-email-linux@roeck-us.net>
 <bd56e90c-5cb8-02d8-3518-c8f5483a6df4@sigmadesigns.com>
 <94c4d5c0-f639-eab1-6706-335977690e88@roeck-us.net>
 <a45ed205-7c1b-a298-50c0-fc8b80a846c5@sigmadesigns.com>
 <a61eb838-4167-3032-bde8-3a8845b780f8@roeck-us.net>
 <f7d9227c-4912-5c52-5ba7-ae7fa3b89857@sigmadesigns.com>
 <20170111175110.GB22289@roeck-us.net>
 <0f68aa11-161b-0435-ea0f-851432464bc1@sigmadesigns.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0f68aa11-161b-0435-ea0f-851432464bc1@sigmadesigns.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Thu, Jan 12, 2017 at 10:44:07AM +0100, Marc Gonzalez wrote:
> On 11/01/2017 18:51, Guenter Roeck wrote:
> 
> > However, some other unrelated undefined behavior does not mean that this
> > specific behavior is undefined.
> 
> True :-)
> 
> Let me just give two additional examples of UB that /have/ bitten
> Linux kernel devs.
> 
> int i;
> for (i = 1; i > 0; ++i)
> 	/* do_something(); */
> 
> => optimized into an infinite loop
> 
> and
> 
> void func(struct foo *p) {
> 	int n = p->field;
> 	if (!p) return;
> 
> => null-pointer check optimized away
> 
> > So far we have a claim that a cast to a void * may somehow be different
> > to a cast to a different pointer, if used as function argument, and that
> > the behavior with such a cast may be undefined. In other words, you claim
> > that a function implemented as, say,
> > 
> >    void func(int *var) {}
> > 
> > might result in undefined behavior if some header file declares it as
> > 
> >     void func(void *);
> > 
> > and it is called as
> > 
> >     int var;
> > 
> >     func(&var);
> > 
> > That seems really far fetched to me.
> 
> Thanks for giving me an opportunity to play the language lawyer :-)
> 
> C99 6.3.2.3 sub-clause 8 states:
> 
> "A pointer to a function of one type may be converted to a pointer to a function of another
> type and back again; the result shall compare equal to the original pointer. If a converted
> pointer is used to call a function whose type is not compatible with the pointed-to type,
> the behavior is undefined."
> 
> So, the behavior is undefined, not when you cast clk_disable_unprepare,
> but when clk_disable_unprepare is later called through the devres->action
> function pointer.
> 
> However, I agree that it will work as expected on typical platforms
> (where all pointers are the same size, and the calling convention
> treats all pointers the same).
> 
> > I do get the message that you do not like this kind of cast. But that doesn't
> > mean it is not correct.
> 
> If it's already widely used in the kernel, it seems there is no point
> fighting it ;-)

I'd say +.5 here (where +1 is an ack). My approach would be to push
devm_clk_prepare_enable and use that. It cannot be that hard, can it?

It looks prettier, is well defined, easier to fit into 80 chars per
line. I wonder why not everybody jubilates on this new function.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
