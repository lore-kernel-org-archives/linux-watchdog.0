Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from smtp-out.google.com ([216.239.44.51]:45550 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932420Ab1DNTBR convert rfc822-to-8bit (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 14 Apr 2011 15:01:17 -0400
Received: from kpbe19.cbf.corp.google.com (kpbe19.cbf.corp.google.com [172.25.105.83])
	by smtp-out.google.com with ESMTP id p3EJ1G5l008522
	for <linux-watchdog@vger.kernel.org>; Thu, 14 Apr 2011 12:01:16 -0700
Received: from yih10 (yih10.prod.google.com [10.243.66.202])
	by kpbe19.cbf.corp.google.com with ESMTP id p3EIxHfQ013153
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=NOT)
	for <linux-watchdog@vger.kernel.org>; Thu, 14 Apr 2011 12:01:10 -0700
Received: by yih10 with SMTP id 10so4229351yih.25
        for <linux-watchdog@vger.kernel.org>; Thu, 14 Apr 2011 12:01:10 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20110413102947.3bf1cc88@lxorguk.ukuu.org.uk>
References: <1302641290-30212-1-git-send-email-natg@google.com>
 <1302641387-30264-1-git-send-email-natg@google.com> <20110413070259.GE4070@infomag.iguana.be>
 <20110413102947.3bf1cc88@lxorguk.ukuu.org.uk>
From: Mike Waychison <mikew@google.com>
Date: Thu, 14 Apr 2011 14:00:49 -0500
Message-ID: <BANLkTinR53LO7HWMWoquKY5D+Aprs2OEWw@mail.gmail.com>
Subject: Re: [PATCH v5 1/2] Use "request_muxed_region" in it87 watchdog drivers
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Wim Van Sebroeck <wim@iguana.be>,
	Nat Gurumoorthy <natg@google.com>,
	Jean Delvare <khali@linux-fr.org>,
	Guenter Roeck <guenter.roeck@ericsson.com>,
	lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org,
	linux-watchdog@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Wed, Apr 13, 2011 at 4:29 AM, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> On Wed, 13 Apr 2011 09:03:00 +0200
> Wim Van Sebroeck <wim@iguana.be> wrote:
>
>> Hi Nat,
>>
>> > +   (void) request_muxed_region(REG, 2, NAME);
>>
>> Why do we need to typecast this? Can't we just use
>> +     request_muxed_region(REG, 2, NAME);
>
> We really ought to use
>
>        if ()
>
> in theory the request can fail if someone has hogged the resource and not
> muxed it. I'm not clear what the right thing to do in that case is -
> given it should never happen I guess log an error and bail out but that's
> a rather bigger change and perhaps should be a follow up patch ?
>

request_muxed_region() is sorta gross:  it's essentially acting like a
lock, meant to be used for short periods of time, but it can fail if
someone else decides it should.

Would it make more sense to have drivers that need to use the current
request_muxed_region() be able to force a region into a mux-only state
at driver init?  That would lead to much less contorted code to handle
the off-chance that the request_muxed_region() fails.

Ie:

Driver init:

if (!request_muxed_region(base, size, DRV_NAME))
   goto cleanup_driver_init_failed;

Driver cleanup

release_muxed_region(base, size); /* returns void */

And then within drivers:

use_muxed_region(base, size); /* sleeps until region is usable --
returns void */
/* Do stuff */
unuse_muxed_region(base, size); /* returns void */



I realize the above example re-uses the 'request_muxed_region()' name,
but at least this would be much more consistent with how
request_region is used in other drivers.
