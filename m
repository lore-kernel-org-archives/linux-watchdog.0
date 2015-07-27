Return-path: <matt@console-pimps.org>
Date: Mon, 27 Jul 2015 15:19:48 +0100
From: Matt Fleming <matt@codeblueprint.co.uk>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Wim Van Sebroeck <wim@iguana.be>, linux-kernel@vger.kernel.org,
	linux-watchdog@vger.kernel.org,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Jean Delvare <jdelvare@suse.com>, Wolfram Sang <wsa@the-dreams.de>,
	Matt Fleming <matt.fleming@intel.com>,
	Peter Tyser <ptyser@xes-inc.com>,
	Samuel Ortiz <sameo@linux.intel.com>,
	Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 1/5] iTCO_wdt: Expose watchdog properties using platform
 data
Message-ID: <20150727141948.GA2677@codeblueprint.co.uk>
References: <1438004292-16382-1-git-send-email-matt@codeblueprint.co.uk>
 <1438004292-16382-2-git-send-email-matt@codeblueprint.co.uk>
 <55B636D4.6020709@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <55B636D4.6020709@roeck-us.net>
List-ID: <linux-watchdog@vger.kernel.org>

On Mon, 27 Jul, at 06:49:08AM, Guenter Roeck wrote:
> 
> I don't see the platform data freed anywhere, neither in the error path nor
> in the cleanup path of this driver. Can you use devm_kzalloc() ?
> Otherwise I think you'll need a cleanup path.

Oops, good catch. Yes, devm_kzalloc() can be used here, thanks!

-- 
Matt Fleming, Intel Open Source Technology Center
