Return-path: <rpjday@crashcourse.ca>
Date: Sun, 16 Oct 2016 11:41:25 -0400 (EDT)
From: "Robert P. J. Day" <rpjday@crashcourse.ca>
To: Guenter Roeck <linux@roeck-us.net>
cc: linux-watchdog@vger.kernel.org
Subject: Re: [PATCH] watchdog: Remove misleading word "legacy" for
 /dev/watchdog
In-Reply-To: <43d28f1d-ddd8-924a-5a9c-80d7fc56de58@roeck-us.net>
Message-ID: <alpine.LFD.2.20.1610161141090.7419@localhost.localdomain>
References: <alpine.LFD.2.20.1610160645550.19356@localhost.localdomain> <43d28f1d-ddd8-924a-5a9c-80d7fc56de58@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-ID: <linux-watchdog@vger.kernel.org>

On Sun, 16 Oct 2016, Guenter Roeck wrote:

> On 10/16/2016 03:49 AM, Robert P. J. Day wrote:
> > The word "legacy" should not be used for the special file
> > /dev/watchdog, as that file is still essential for watchdog
> > operations.
> >
>
> NAK. The non-legacy name is /dev/watchdog0.

  ah, that wasn't clear from the source file.

rday

-- 

========================================================================
Robert P. J. Day                                 Ottawa, Ontario, CANADA
                        http://crashcourse.ca

Twitter:                                       http://twitter.com/rpjday
LinkedIn:                               http://ca.linkedin.com/in/rpjday
========================================================================
