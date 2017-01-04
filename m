Return-path: <mika.westerberg@linux.intel.com>
Date: Wed, 4 Jan 2017 14:34:55 +0200
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Wim Van Sebroeck <wim@iguana.be>, linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v2 1/4] watchdog: iTCO_wdt: Use allocated data structures
Message-ID: <20170104123455.GR3353@lahna.fi.intel.com>
References: <1483499655-24562-1-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1483499655-24562-1-git-send-email-linux@roeck-us.net>
List-ID: <linux-watchdog@vger.kernel.org>

On Tue, Jan 03, 2017 at 07:14:12PM -0800, Guenter Roeck wrote:
> Allocate private data and the watchdog device to avoid having
> to clear it on remove and to enable subsequent simplifications.
> 
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>

Really nice cleanup!

For the whole series,

Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
