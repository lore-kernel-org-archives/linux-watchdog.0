Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pg1-f169.google.com ([209.85.215.169]:44267 "EHLO
        mail-pg1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725825AbeIEFXd (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Wed, 5 Sep 2018 01:23:33 -0400
Received: by mail-pg1-f169.google.com with SMTP id r1-v6so2489074pgp.11
        for <linux-watchdog@vger.kernel.org>; Tue, 04 Sep 2018 17:55:56 -0700 (PDT)
Subject: Re: [PATCH v2 2/4] dt-bindings: watchdog: Document armada-37xx-wdt
 binding
To: =?UTF-8?Q?Marek_Beh=c3=ban?= <marek.behun@nic.cz>,
        linux-watchdog@vger.kernel.org
Cc: wim@linux-watchdog.org,
        Gregory CLEMENT <gregory.clement@bootlin.com>
References: <20180904095627.25552-1-marek.behun@nic.cz>
 <20180904095627.25552-2-marek.behun@nic.cz>
 <20180904120007.34c6b4a7@dellmb.labs.office.nic.cz>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <2e522394-e8ea-badf-5db2-b01a6c391462@roeck-us.net>
Date: Tue, 4 Sep 2018 17:55:54 -0700
MIME-Version: 1.0
In-Reply-To: <20180904120007.34c6b4a7@dellmb.labs.office.nic.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 09/04/2018 03:00 AM, Marek Behún wrote:
> Hi Guenter,
> I have sent this patch to devicetree mailing list on Friday but no one
> was able to review it yet. I wanted to wait till they review it before
> sending these patches so that you could apply them if there are no more
> problems, but after three days I sent them anyway so at least you could
> watch the rest of the changes.
> 

You should have copied the dt maintainers on _this_ patch. Not doing so
means that we will likely miss the DT maintainer's Ack, which in turn will
mean that we won't apply the entire series. And if we _do_ notice the DT
maintainer Ack for some reason, we'll have to manually add it to this
patch (which is the one we are tracking) because patchwork won't see it.

In other words, you have created a lot of additional work for maintainers
and risk for the series for no good reason by submitting the same patch
multiple times to different people. Always keep patches together in a
series, and never submit the same patch multiple times to different mailing
lists/people.

Guenter
