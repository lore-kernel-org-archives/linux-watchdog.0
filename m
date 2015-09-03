Return-path: <panand@redhat.com>
Date: Thu, 3 Sep 2015 16:54:16 +0530
From: Pratyush Anand <panand@redhat.com>
To: Guenter Roeck <linux@roeck-us.net>
Cc: dyoung@redhat.com, dzickus@redhat.com, linux-watchdog@vger.kernel.org,
        open list:  ABI/API <linux-api@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Wim Van Sebroeck <wim@iguana.be>
Subject: Re: [PATCH V3 2/2] watchdog: Read device status through sysfs
 attributes
Message-ID: <20150903112416.GA636@dhcppc13.redhat.com>
References: <cover.1441249584.git.panand@redhat.com>
 <20b1ed49430632e1de8f266fe6daaccb590ef571.1441249584.git.panand@redhat.com>
 <55E82670.2090101@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <55E82670.2090101@roeck-us.net>
List-ID: <linux-watchdog@vger.kernel.org>

On 03/09/2015:03:52:32 AM, Guenter Roeck wrote:
> On 09/02/2015 08:22 PM, Pratyush Anand wrote:
> >This patch adds following attributes to watchdog device's sysfs interface
> >to read its different status.
> >
> >* state - reads whether device is active or not
> >* identity - reads Watchdog device's identity string.
> >* timeout - reads current timeout.
> >* timeleft - reads timeleft before watchdog generates a reset
> >* bootstatus - reads status of the watchdog device at boot
> >* status - reads watchdog device's  internal status bits
> >* nowayout - reads whether nowayout feature was set or not
> >
> >Testing with iTCO_wdt:
> >  # cd /sys/class/watchdog/watchdog1/
> >  # ls
> >bootstatus  dev  device  identity  nowayout  power  state
> >subsystem  timeleft  timeout  uevent
> >  # cat identity
> >iTCO_wdt
> >  # cat timeout
> >30
> >  # cat state
> >inactive
> >  # echo > /dev/watchdog1
> >  # cat timeleft
> >26
> >  # cat state
> >active
> >  # cat bootstatus
> >0
> >  # cat nowayout
> >0
> >
> >Signed-off-by: Pratyush Anand <panand@redhat.com>
> 
> Looks good, except for
> 
> WARNING: please, no space before tabs
> #250: FILE: drivers/watchdog/watchdog_dev.c:693:
> +^I.dev_groups = ^Iwdt_groups,$
> 
> [ there is a space after '=' ]
> 
> Assuming you fix that,
> 
> Reviewed-by: Guenter Roeck <linux@roeck-us.net>
> 

Thanks a lot for the review.
I will fix it and will send it again.

~Pratyush
