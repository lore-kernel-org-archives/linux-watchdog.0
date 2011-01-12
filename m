Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:33362 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754054Ab1ALMdP (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 12 Jan 2011 07:33:15 -0500
Received: by wyb28 with SMTP id 28so489640wyb.19
        for <linux-watchdog@vger.kernel.org>; Wed, 12 Jan 2011 04:33:13 -0800 (PST)
Date: Wed, 12 Jan 2011 12:33:11 +0000
From: Jamie Iles <jamie@jamieiles.com>
To: viresh kumar <viresh.linux@gmail.com>
Cc: Jamie Iles <jamie@jamieiles.com>, linux-watchdog@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Wim Van Sebroeck <wim@iguana.be>
Subject: Re: [PATCH] watchdog: add support for the Synopsys DesignWare WDT
Message-ID: <20110112123311.GD2658@pulham.picochip.com>
References: <1294675181-18273-1-git-send-email-jamie@jamieiles.com>
 <AANLkTikbxyCSX5eKiwtZyW+gYToTD7Jcucst6su2fEjN@mail.gmail.com>
 <20110112082416.GE3181@pulham.picochip.com>
 <AANLkTim2LJVA+qJNqYd2uPNKjP54kuyvsZ7-T3jSJsta@mail.gmail.com>
 <20110112113054.GA2658@pulham.picochip.com>
 <AANLkTimtW4GZmjL0ryi1HgOMrCC4gMfGDdEqLJgW_2YA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <AANLkTimtW4GZmjL0ryi1HgOMrCC4gMfGDdEqLJgW_2YA@mail.gmail.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Wed, Jan 12, 2011 at 05:08:42PM +0530, viresh kumar wrote:
> On Wed, Jan 12, 2011 at 5:00 PM, Jamie Iles <jamie@jamieiles.com> wrote:
> > On Wed, Jan 12, 2011 at 02:27:47PM +0530, viresh kumar wrote:
> >> On Wed, Jan 12, 2011 at 1:54 PM, Jamie Iles <jamie@jamieiles.com> wrote:
> >> >> I don't know why, but checkpatch used to give few errors which it is
> >> >> not giving now.
> >> >> Like:
> >> >> - Mixing spaces and tabs
> >> >> - Line over 80 columns.
> >> >>
> > I do need to fix up the register locations (40-45) but the others are ok
> > - they are tab indented to get to a multiple of 8 then spaces to align
> > to the '(' brackets etc.
> 
> That's what i said. Checkpatch used to give warning for them earlier.
> I don't know if it is correct or not. Anyway, others will comment if it is
> still a issue. You can keep that as it is.
> 
> >> Problem will occur if rate is dynamically changed and we are still believing
> >> on platform code's clk_rate.
> >> Would be better if we switch order. i.e. give priority to clk_get_rate over
> >> pdata->rate.
> >
> > If the platform can change the rate then I don't see why it would define
> > the rate in the platform data though.  Anyway, I can make the change and
> > issue a warning and fail the probe if we're using the rate from
> > clk_get_rate() and there is a non-zero rate in the platform data.
> 
> that's better.

Ok, I'll give Wim chance to have a look over v5 then I'll integrate 
these changes.

Thanks again for the review.

Jamie
