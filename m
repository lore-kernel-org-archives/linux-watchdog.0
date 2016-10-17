Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:45294 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757513AbcJQNXi (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Mon, 17 Oct 2016 09:23:38 -0400
Subject: Re: is watchdog_ops stop() routine mandatory or optional?
To: "Robert P. J. Day" <rpjday@crashcourse.ca>,
        Linux watchdog mailing list <linux-watchdog@vger.kernel.org>
References: <alpine.LFD.2.20.1610170638260.6042@ca624034.mitel.com>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <83fbc8ba-5f1c-9420-2e64-3008abc433ee@roeck-us.net>
Date: Mon, 17 Oct 2016 06:23:35 -0700
MIME-Version: 1.0
In-Reply-To: <alpine.LFD.2.20.1610170638260.6042@ca624034.mitel.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 10/17/2016 03:42 AM, Robert P. J. Day wrote:
>
>   continuing with annoying pedantry, there's this from
> Documentation/watchdog/watchdog-kernel-api.txt:
>
>   The list of watchdog operations is defined as:
>
>   struct watchdog_ops {
>         struct module *owner;
>         /* mandatory operations */
>         int (*start)(struct watchdog_device *);
>         int (*stop)(struct watchdog_device *);
>         /* optional operations */
>         ... snip ...
>
> followed shortly by:
>
> Some operations are mandatory and some are optional. The mandatory operations
> are:
> * start: this is a pointer to the routine that starts the watchdog timer
>   device.
>   The routine needs a pointer to the watchdog timer device structure as a
>   parameter. It returns zero on success or a negative errno code for failure.
>
> Not all watchdog timer hardware supports the same functionality. That's why
> all other routines/operations are optional. They only need to be provided if
> they are supported. These optional routines/operations are:
> * stop: with this routine the watchdog timer device is being stopped.
> ... snip ...
>
>   so the first snippet implies that stop() is mandatory, while the
> subsequent snippet describes it as optional. thoughts?
>

stop used to be mandatory, but isn't anymore. I missed updating the structure.

Guenter

> rday
>
> p.s. i am currently editing this doc file, and will submit an updated
> version with little fixes throughout.
>

