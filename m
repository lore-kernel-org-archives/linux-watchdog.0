Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:46944 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752715AbdGHPhI (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Sat, 8 Jul 2017 11:37:08 -0400
Date: Sat, 8 Jul 2017 08:37:02 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: =?iso-8859-1?B?Wm9sdOFuIEL2c3r2cm3pbnlp?= <zboszor@pr.hu>
Cc: linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-watchdog@vger.kernel.org, linux-i2c@vger.kernel.org,
        Paul Menzel <paulepanter@users.sourceforge.net>,
        Christian Fetzer <fetzer.ch@gmail.com>,
        Jean Delvare <jdelvare@suse.com>,
        Nehal Shah <nehal-bakulchandra.shah@amd.com>,
        Tim Small <tim@seoss.co.uk>, kernel@ekass.net, wim@iguana.be,
        jlayton@poochiereds.net, marc.2377@gmail.com,
        cshorler@googlemail.com, wsa@the-dreams.de,
        regressions@leemhuis.info
Subject: Re: [2/5,v2] Modify behaviour of request_*muxed_region()
Message-ID: <20170708153702.GA17711@roeck-us.net>
References: <20170622132134.7200-3-zboszor@pr.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20170622132134.7200-3-zboszor@pr.hu>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Thu, Jun 22, 2017 at 03:21:31PM +0200, Zoltán Böszörményi wrote:
> In order to make request_*muxed_region() behave more like
> mutex_lock(), a possible failure case needs to be eliminated.
> When drivers do not properly share the same I/O region, e.g.
> one is using request_region() and the other is using
> request_muxed_region(), the kernel didn't warn the user about it.
> This change modifies IORESOURCE_MUXED behaviour so it always
> goes to sleep waiting for the resuorce to be freed and the
> inconsistent resource flag usage is logged with KERN_ERR.
> 
> v2: Fixed checkpatch.pl warnings and extended the comment
>     about request_declared_muxed_region.
> 
> Signed-off-by: Zoltán Böszörményi <zboszor@pr.hu>

It might make sense to go through your series, determine who touched
the files you are changing and who was Cc:'d, and use that to create
a useful list of people to Cc:. You copied a lot of people, but I don't
see anyone who recently touched this file. The same is true for your other
'core' patches. In some cases you did not even copy the maintainer(s).
It might also make sense to add explicit "Cc:" entries, to inform people
that you expect them to provide feedback.

As it is, it will be all but impossible to get your patch series accepted,
simply because the people in position to approve the core changes don't
know about it.

Guenter

> ---
>  kernel/resource.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/resource.c b/kernel/resource.c
> index 2be7029..5df2731 100644
> --- a/kernel/resource.c
> +++ b/kernel/resource.c
> @@ -1125,6 +1125,7 @@ resource_size_t resource_alignment(struct resource *res)
>   *
>   * request_declared_muxed_region creates a new shared busy region
>   * described in an existing resource descriptor.
> + * It only returns if it succeeded.
>   *
>   * release_region releases a matching busy region.
>   * The region is only freed if it was allocated.
> @@ -1191,7 +1192,10 @@ struct resource *__request_declared_region(struct resource *parent,
>  				continue;
>  			}
>  		}
> -		if (conflict->flags & flags & IORESOURCE_MUXED) {
> +		if (flags & IORESOURCE_MUXED) {
> +			if (!(conflict->flags & IORESOURCE_MUXED))
> +				pr_err("Resource conflict between muxed \"%s\" and non-muxed \"%s\" I/O regions!\n",
> +					res->name, conflict->name);
>  			add_wait_queue(&muxed_resource_wait, &wait);
>  			write_unlock(&resource_lock);
>  			set_current_state(TASK_UNINTERRUPTIBLE);
