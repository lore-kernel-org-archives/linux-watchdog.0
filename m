Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pv0-f174.google.com ([74.125.83.174]:33111 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753400Ab0IOTbl (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 15 Sep 2010 15:31:41 -0400
From: Kevin Hilman <khilman@deeprootsystems.com>
To: Tony Lindgren <tony@atomide.com>
Cc: wim@iguana.be, linux-watchdog@vger.kernel.org, paul@pwsan.com,
	b-cousson@ti.com, rnayak@ti.com, p-basak2@ti.com,
	linux-omap@vger.kernel.org,
	"Varadarajan\, Charulatha" <charu@ti.com>
Subject: Re: [PATCH v5 6/6] OMAP: WDT: Use PM runtime APIs instead of clk FW APIs
References: <1284528403-6494-1-git-send-email-charu@ti.com>
	<1284528403-6494-7-git-send-email-charu@ti.com>
	<87fwxbgj55.fsf@deeprootsystems.com>
	<20100915175540.GD4174@atomide.com>
Date: Wed, 15 Sep 2010 12:31:37 -0700
In-Reply-To: <20100915175540.GD4174@atomide.com> (Tony Lindgren's message of
	"Wed, 15 Sep 2010 10:55:40 -0700")
Message-ID: <87ocbydcrq.fsf@deeprootsystems.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Tony Lindgren <tony@atomide.com> writes:

> * Kevin Hilman <khilman@deeprootsystems.com> [100915 07:37]:
>> Hi Wim,
>> 
>> "Varadarajan, Charulatha" <charu@ti.com> writes:
>> 
>> > Call runtime pm APIs pm_runtime_put_sync() and pm_runtime_get_sync()
>> > for enabling/disabling the clocks, sysconfig settings instead of using
>> > clock FW APIs.
>> >
>> > Signed-off-by: Charulatha V <charu@ti.com>
>> 
>> With your ack, I'll be glad to merge this via the OMAP tree since it
>> depends on the rest of the series for the OMAP platform specific
>> changes.
>
> Just checking.. The pm_runtime functions are implemented as
> clk_enable/disable functions for omap1, right?

Yes.

Kevin
