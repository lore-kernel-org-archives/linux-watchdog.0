Return-Path: <akpm@linux-foundation.org>
Date: Thu, 10 Jul 2014 17:44:25 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: linux-watchdog@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Wim Van Sebroeck <wim@iguana.be>, Catalin Marinas
 <catalin.marinas@arm.com>, Maxime Ripard
 <maxime.ripard@free-electrons.com>, Will Deacon <will.deacon@arm.com>, Arnd
 Bergmann <arnd@arndb.de>, Heiko Stuebner <heiko@sntech.de>, Russell King
 <linux@arm.linux.org.uk>, Jonas Jensen <jonas.jensen@gmail.com>, Randy
 Dunlap <rdunlap@infradead.org>, Steven Rostedt <rostedt@goodmis.org>, Ingo
 Molnar <mingo@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>,
 David Woodhouse <dwmw2@infradead.org>, Tomasz Figa <t.figa@samsung.com>,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/7] kernel: Add support for restart notifier call
 chain
Message-Id: <20140710174425.2f3fea98.akpm@linux-foundation.org>
In-Reply-To: <53BF2CB5.5080602@roeck-us.net>
References: <1404877083-6552-1-git-send-email-linux@roeck-us.net>
	<20140710160907.da1024914366de947ebdf384@linux-foundation.org>
	<53BF2CB5.5080602@roeck-us.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
List-ID: <linux-watchdog@vger.kernel.org>

On Thu, 10 Jul 2014 17:15:49 -0700 Guenter Roeck <linux@roeck-us.net> wrote:

> Error on my part - I thought lower numbers would
> have higher priority, but after looking into the code again that
> is wrong.

You shouldn't have needed to look into the code :( Maybe a
documentation patch for notifier_block.priority for the next person?

> To avoid making things too complicated, maybe it would make sense to
> specify guidelines for notifier priorities, such as
> 0   - restart notifier of last resort, with least reset capabilities
> 128 - default; use if no other notifier is expected to be available
>        and/or if restart functionality is acceptable
> 255 - highest priority notifier which _must_ be used
> 
> Would that make sense and be acceptable ? In this context, I would then
> set the notifier priorities for the callers in the patch set to 128.

Yep, that sounds nice.  It's unlikely to see a lot of use, but at least
we showed we thought about it ;)
