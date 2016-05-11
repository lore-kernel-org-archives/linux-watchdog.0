Return-path: <vilhelm.gray@gmail.com>
Date: Wed, 11 May 2016 09:58:02 -0400
From: William Breathitt Gray <vilhelm.gray@gmail.com>
To: Guenter Roeck <linux@roeck-us.net>
Cc: wim@iguana.be, linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] watchdog: ebc-c384_wdt: Simplify ebc_c384_wdt_start
 timeout computation
Message-ID: <20160511135802.GA624@sophia>
References: <20160511130551.GA16032@sophia>
 <20160511134327.GA8192@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20160511134327.GA8192@roeck-us.net>
List-ID: <linux-watchdog@vger.kernel.org>

On Wed, May 11, 2016 at 06:43:27AM -0700, Guenter Roeck wrote:
>On Wed, May 11, 2016 at 09:05:51AM -0400, William Breathitt Gray wrote:
>> The ebc_c384_wdt_set_timeout function already rounds up timeout values
>> greater than 255 to a multiple of 60, so there is no need to round again
>> in the ebc_c384_wdt_start function; a timeout value greater than 255 in
>> ebc_c384_wdt_start will divide cleanly by 60.
>> 
>... except if the timeout is set with the module parameter, which is now
>rounded down, which would be a problem since it would time out earlier than
>expected (a timeout of 299 seconds, set with the module parameter, would
>time out after 240 seconds). So you would have to do some calculations
>on the timeout value set with the module parameter to ensure that it is
>set to a correct value.
>
>Guenter

Oops, I overlooked that scenario. Please ignore this patch as your are
correct that a timeout set via module parameter would not necessarily be
a multiple of 60; timeout in the start callback should indeed be
rounded.

William Breathitt Gray
