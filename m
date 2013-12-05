Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail.active-venture.com ([67.228.131.205]:58187 "EHLO
	mail.active-venture.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756451Ab3LECqz (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 4 Dec 2013 21:46:55 -0500
Message-ID: <529FE919.9060604@roeck-us.net>
Date: Wed, 04 Dec 2013 18:46:49 -0800
From: Guenter Roeck <linux@roeck-us.net>
MIME-Version: 1.0
To: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>
CC: wim@iguana.be, linux-watchdog@vger.kernel.org
Subject: Re: [PATCH] sc1200_wdt: Fix oops
References: <20131204153135.32175.35874.stgit@alan.etchedpixels.co.uk>	<20131204163118.GA1299@roeck-us.net> <20131205001511.6c8e9f60@alan.etchedpixels.co.uk>
In-Reply-To: <20131205001511.6c8e9f60@alan.etchedpixels.co.uk>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 12/04/2013 04:15 PM, One Thousand Gnomes wrote:
> On Wed, 4 Dec 2013 08:31:18 -0800
> Guenter Roeck <linux@roeck-us.net> wrote:
>
>> On Wed, Dec 04, 2013 at 03:31:52PM +0000, Alan wrote:
>>> If loaded with isapnp = 0 the driver explodes. This is catching
>>> people out now and then. What should happen in the working case is
>>> a complete mystery and the code appears terminally confused, but we
>>
>> Looks like it uses the pnp infrastructure only to auto-detect the
>> "io" address, and assumes that pnp_register_driver() calls the
>> pnp probe function immediately. Afterwards it unregisters and
>> works (or is supposed to work) outside the pnp subsystem. Brr.
>>
>>> can at least make the error path work properly.
>>>
>>> Signed-off-by: Alan Cox <alan@linux.intel.com>
>>> Partially-Resolves-bug: https://bugzilla.kernel.org/show_bug.cgi?id=53991
>>
>> Actually, I think it fully resolves it, because the other part (sc520 driver
>> not working on SC1100 CPU) isn't a bug. It isn't working on an ARM or PPC CPU
>> either, nor on any Intel CPU.
>
> As far as I can tell the fact it fails on the sc1100 is also a bug - but
> the mess of idefs around PNP is impossible to figure out without some
> actual docs, time and real hardware.
>

... unless isapnp was set to 0 via module parameter, or if SC1100 is not compatible
with SC1200. But I agree, hard to say w/o datasheet and hw.

Either case, seems to me the driver is screaming for a substantial overhaul.

Guenter

