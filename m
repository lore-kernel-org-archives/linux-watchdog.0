Return-path: <Marc_Gonzalez@sigmadesigns.com>
Subject: Re: [PATCH 56/62] watchdog: tangox_wdt: Convert to use device managed
 functions
To: Guenter Roeck <linux@roeck-us.net>
CC: Wim Van Sebroeck <wim@iguana.be>, <linux-watchdog@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	"Mans Rullgard" <mans@mansr.com>, Thibaud Cornic
	<thibaud_cornic@sigmadesigns.com>, Mark Rutland <mark.rutland@arm.com>, Uwe
 Kleine-Konig <u.kleine-koenig@pengutronix.de>, Arnd Bergmann <arnd@arndb.de>
References: <1484091325-9199-1-git-send-email-linux@roeck-us.net>
 <1484100561-17638-1-git-send-email-linux@roeck-us.net>
 <1484100561-17638-5-git-send-email-linux@roeck-us.net>
 <bd56e90c-5cb8-02d8-3518-c8f5483a6df4@sigmadesigns.com>
 <94c4d5c0-f639-eab1-6706-335977690e88@roeck-us.net>
 <a45ed205-7c1b-a298-50c0-fc8b80a846c5@sigmadesigns.com>
 <a61eb838-4167-3032-bde8-3a8845b780f8@roeck-us.net>
 <f7d9227c-4912-5c52-5ba7-ae7fa3b89857@sigmadesigns.com>
 <20170111175110.GB22289@roeck-us.net>
From: Marc Gonzalez <marc_gonzalez@sigmadesigns.com>
Message-ID: <0f68aa11-161b-0435-ea0f-851432464bc1@sigmadesigns.com>
Date: Thu, 12 Jan 2017 10:44:07 +0100
MIME-Version: 1.0
In-Reply-To: <20170111175110.GB22289@roeck-us.net>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Language: 
Content-Transfer-Encoding: 7bit
List-ID: <linux-watchdog@vger.kernel.org>

On 11/01/2017 18:51, Guenter Roeck wrote:

> However, some other unrelated undefined behavior does not mean that this
> specific behavior is undefined.

True :-)

Let me just give two additional examples of UB that /have/ bitten
Linux kernel devs.

int i;
for (i = 1; i > 0; ++i)
	/* do_something(); */

=> optimized into an infinite loop

and

void func(struct foo *p) {
	int n = p->field;
	if (!p) return;

=> null-pointer check optimized away

> So far we have a claim that a cast to a void * may somehow be different
> to a cast to a different pointer, if used as function argument, and that
> the behavior with such a cast may be undefined. In other words, you claim
> that a function implemented as, say,
> 
>    void func(int *var) {}
> 
> might result in undefined behavior if some header file declares it as
> 
>     void func(void *);
> 
> and it is called as
> 
>     int var;
> 
>     func(&var);
> 
> That seems really far fetched to me.

Thanks for giving me an opportunity to play the language lawyer :-)

C99 6.3.2.3 sub-clause 8 states:

"A pointer to a function of one type may be converted to a pointer to a function of another
type and back again; the result shall compare equal to the original pointer. If a converted
pointer is used to call a function whose type is not compatible with the pointed-to type,
the behavior is undefined."

So, the behavior is undefined, not when you cast clk_disable_unprepare,
but when clk_disable_unprepare is later called through the devres->action
function pointer.

However, I agree that it will work as expected on typical platforms
(where all pointers are the same size, and the calling convention
treats all pointers the same).

> I do get the message that you do not like this kind of cast. But that doesn't
> mean it is not correct.

If it's already widely used in the kernel, it seems there is no point
fighting it ;-)

Regards.
