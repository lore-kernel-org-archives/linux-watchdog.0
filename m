Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pf1-f194.google.com ([209.85.210.194]:42853 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726567AbeH1Rzl (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Tue, 28 Aug 2018 13:55:41 -0400
Subject: Re: [RFC PATCH] watchdog: HACK: disable bind attributes with NOWAYOUT
To: Wolfram Sang <wsa@the-dreams.de>, linux-watchdog@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org,
        Wolfram Sang <wsa+renesas@sang-engineering.com>
References: <20180828102906.12840-1-wsa@the-dreams.de>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <3d3a5bde-b8bd-0810-5571-cdc64cd57ee4@roeck-us.net>
Date: Tue, 28 Aug 2018 07:03:49 -0700
MIME-Version: 1.0
In-Reply-To: <20180828102906.12840-1-wsa@the-dreams.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 08/28/2018 03:29 AM, Wolfram Sang wrote:
> With NOWAYOUT, prevent bind/unbind possibilities in SYSFS.
> Proof-of-concept, not for upstream yet.
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
> 
> So, this is really an RFC to check if something like this is considered useful
> or not. If so, we probably need to do it differently because modifying the
> parent's driver is likely a layering violation. We could add the driver to
> modify as an optional parameter to watchdog_set_nowayout(). I wouldn't favor
> another seperate function to configure this, but am open for discussion.
> 
> Thanks,
> 
>     Wolfram
> 
>   include/linux/watchdog.h | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/watchdog.h b/include/linux/watchdog.h
> index 44985c4a1e86..241de0fa0010 100644
> --- a/include/linux/watchdog.h
> +++ b/include/linux/watchdog.h
> @@ -143,8 +143,10 @@ static inline bool watchdog_hw_running(struct watchdog_device *wdd)
>   /* Use the following function to set the nowayout feature */
>   static inline void watchdog_set_nowayout(struct watchdog_device *wdd, bool nowayout)
>   {
> -	if (nowayout)
> +	if (nowayout) {
>   		set_bit(WDOG_NO_WAY_OUT, &wdd->status);
> +		wdd->parent->driver->suppress_bind_attrs = true;

That makes sense to me. We can not assume that wdd->parent is set, so it won't work as-is.
Not sure what a "correct" solution might be. Passing "parent" as argument doesn't really
solve any layering argument - stating that it violates layering if parent is pulled from
wdd but not if it is passed as argument seems to be a bit ridiculous.

Did you ensure that the attributes are not already created by the time
suppress_bind_attrs is set ?

Thanks,
Guenter
