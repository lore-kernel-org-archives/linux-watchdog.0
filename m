Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:63038 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752136Ab1ALLim convert rfc822-to-8bit (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 12 Jan 2011 06:38:42 -0500
Received: by iyj18 with SMTP id 18so400203iyj.19
        for <linux-watchdog@vger.kernel.org>; Wed, 12 Jan 2011 03:38:42 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20110112113054.GA2658@pulham.picochip.com>
References: <1294675181-18273-1-git-send-email-jamie@jamieiles.com>
	<AANLkTikbxyCSX5eKiwtZyW+gYToTD7Jcucst6su2fEjN@mail.gmail.com>
	<20110112082416.GE3181@pulham.picochip.com>
	<AANLkTim2LJVA+qJNqYd2uPNKjP54kuyvsZ7-T3jSJsta@mail.gmail.com>
	<20110112113054.GA2658@pulham.picochip.com>
Date: Wed, 12 Jan 2011 17:08:42 +0530
Message-ID: <AANLkTimtW4GZmjL0ryi1HgOMrCC4gMfGDdEqLJgW_2YA@mail.gmail.com>
Subject: Re: [PATCH] watchdog: add support for the Synopsys DesignWare WDT
From: viresh kumar <viresh.linux@gmail.com>
To: Jamie Iles <jamie@jamieiles.com>
Cc: linux-watchdog@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Wim Van Sebroeck <wim@iguana.be>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Wed, Jan 12, 2011 at 5:00 PM, Jamie Iles <jamie@jamieiles.com> wrote:
> On Wed, Jan 12, 2011 at 02:27:47PM +0530, viresh kumar wrote:
>> On Wed, Jan 12, 2011 at 1:54 PM, Jamie Iles <jamie@jamieiles.com> wrote:
>> >> I don't know why, but checkpatch used to give few errors which it is
>> >> not giving now.
>> >> Like:
>> >> - Mixing spaces and tabs
>> >> - Line over 80 columns.
>> >>
> I do need to fix up the register locations (40-45) but the others are ok
> - they are tab indented to get to a multiple of 8 then spaces to align
> to the '(' brackets etc.

That's what i said. Checkpatch used to give warning for them earlier.
I don't know if it is correct or not. Anyway, others will comment if it is
still a issue. You can keep that as it is.

>> Problem will occur if rate is dynamically changed and we are still believing
>> on platform code's clk_rate.
>> Would be better if we switch order. i.e. give priority to clk_get_rate over
>> pdata->rate.
>
> If the platform can change the rate then I don't see why it would define
> the rate in the platform data though.  Anyway, I can make the change and
> issue a warning and fail the probe if we're using the rate from
> clk_get_rate() and there is a non-zero rate in the platform data.

that's better.

--
viresh
