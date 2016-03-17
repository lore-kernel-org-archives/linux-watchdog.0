Return-path: <rcochran@linutronix.de>
Date: Thu, 17 Mar 2016 14:51:33 +0100
From: rcochran@linutronix.de
To: Guenter Roeck <linux@roeck-us.net>
Cc: Wim Van Sebroeck <wim@iguana.be>, linux-watchdog@vger.kernel.org,
	rt@linutronix.de
Subject: Re: watchdog: octeon: missing FROZEN hot plug notifier actions
Message-ID: <20160317135133.GE3248@linutronix.de>
References: <20160316205105.GA14847@linutronix.de>
 <56EA21FE.6040009@roeck-us.net>
 <20160317080820.GA32637@linutronix.de>
 <56EAAB5E.10703@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <56EAAB5E.10703@roeck-us.net>
List-ID: <linux-watchdog@vger.kernel.org>

On Thu, Mar 17, 2016 at 06:04:30AM -0700, Guenter Roeck wrote:
> The default Octeon configuration at least enables CONFIG_PM and CONFIG_PM_SLEEP,
> so one can argue that it should be supported. If you submit a patch, would you
> be able to test your changes ?

No, due to -ENODEV.


Sorry,
Richard
