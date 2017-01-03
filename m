Return-path: <andy.shevchenko@gmail.com>
MIME-Version: 1.0
In-Reply-To: <8fb3f1a7-1b72-8da3-adcd-11677c455f82@roeck-us.net>
References: <8fb3f1a7-1b72-8da3-adcd-11677c455f82@roeck-us.net>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 4 Jan 2017 01:55:39 +0200
Message-ID: <CAHp75VcPRkscW8MaM3-nO-tzJnuC9f2fa3wc6oODo_aq+9Wdcg@mail.gmail.com>
Subject: Re: Auto-conversion of watchdog drivers to use devm functions
To: Guenter Roeck <linux@roeck-us.net>
Cc: "wim@iguana.be" <wim@iguana.be>,
	"linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-watchdog@vger.kernel.org>

On Mon, Jan 2, 2017 at 1:53 AM, Guenter Roeck <linux@roeck-us.net> wrote:
> Hi Wim,
>
> With heavy support by Julia Lawall, I created a number of coccinelle scripts
> to auto-convert watchdog platform drivers to use devm functions. The result
> is quite impressive - many drivers won't even need remove functions anymore
> after the conversion.
>
> Question is now how to submit the patches. There are 12 rule files affecting
> a total of 62 drivers. Should I submit one patch per driver (62 patches),
> one patch per rule (12), or one patch per rule file per driver (183) ?

One per driver.

> Also, how should I refer to the rules ? The total number of rule lines
> is more than 1,000, which seems to be a bit much for the commit log (even
> though not all rules apply to all files).

No need, perhaps some URL?

-- 
With Best Regards,
Andy Shevchenko
