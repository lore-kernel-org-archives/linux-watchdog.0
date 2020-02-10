Return-Path: <SRS0=j7i1=36=vger.kernel.org=linux-watchdog-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEB95C352A3
	for <linux-watchdog@archiver.kernel.org>; Mon, 10 Feb 2020 10:16:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD80C20733
	for <linux-watchdog@archiver.kernel.org>; Mon, 10 Feb 2020 10:16:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727507AbgBJKQu (ORCPT
        <rfc822;linux-watchdog@archiver.kernel.org>);
        Mon, 10 Feb 2020 05:16:50 -0500
Received: from mx2.suse.de ([195.135.220.15]:43592 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727499AbgBJKQu (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Mon, 10 Feb 2020 05:16:50 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 790F3ACCA;
        Mon, 10 Feb 2020 10:16:48 +0000 (UTC)
Date:   Mon, 10 Feb 2020 11:16:38 +0100
From:   Jean Delvare <jdelvare@suse.de>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-watchdog@vger.kernel.org,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Tom Abraham <tabraham@suse.com>
Subject: wdat_wdt: access width inconsistency
Message-ID: <20200210111638.64925c8e@endymion>
Organization: SUSE Linux
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-watchdog.vger.kernel.org>
X-Mailing-List: linux-watchdog@vger.kernel.org

Hi all,

I'm still working on my customer issue where the wdat_wdt driver
reboots the server instantly as soon as the watchdog daemon is started.
I looked at all the upstream fixes and we already have all relevant
ones in our kernel so I start suspecting either a driver bug or a BIOS
issue.

While reading the driver code I noticed one suspect thing related to
the register access width, which I'd like a second opinion on.

Both acpi_watchdog.c and wdat_wdt.c contain code like:

	res.end = res.start + gas->access_width - 1;

This suggests that gas->access_width is expected to be 4 in case of a
32-bit register. However in wdat_wdt_read/wdat_wdt_write we have:

	switch (gas->access_width) {
	(...)
	case 3:
		*value = ioread32(instr->reg);

This looks inconsistent to me.

My reading of the ACPI specification suggests that 3 is the right value
for 32-bit registers. If so, then shouldn't the resource's end be set
to:

	res.end = res.start + (1 << (gas->access_width - 1)) - 1;

?

Thanks,
-- 
Jean Delvare
SUSE L3 Support
