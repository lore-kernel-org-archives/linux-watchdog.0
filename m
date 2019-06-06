Return-Path: <SRS0=zSU+=UF=vger.kernel.org=linux-watchdog-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D07A6C04AB5
	for <linux-watchdog@archiver.kernel.org>; Thu,  6 Jun 2019 10:01:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACDDB20883
	for <linux-watchdog@archiver.kernel.org>; Thu,  6 Jun 2019 10:01:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727734AbfFFKBf (ORCPT
        <rfc822;linux-watchdog@archiver.kernel.org>);
        Thu, 6 Jun 2019 06:01:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54918 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726972AbfFFKBf (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Thu, 6 Jun 2019 06:01:35 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 38C935F79B;
        Thu,  6 Jun 2019 10:01:35 +0000 (UTC)
Received: from ws.net.home (unknown [10.40.205.108])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 770E3183BC;
        Thu,  6 Jun 2019 10:01:34 +0000 (UTC)
Date:   Thu, 6 Jun 2019 12:01:31 +0200
From:   Karel Zak <kzak@redhat.com>
To:     Wim Van Sebroeck <wim@iguana.be>, linux-watchdog@vger.kernel.org
Subject: RFE: export watchdog features and version by /sys
Message-ID: <20190606100131.2xgrs5cmtnj4hjyb@ws.net.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20180716-1584-710bcd
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Thu, 06 Jun 2019 10:01:35 +0000 (UTC)
Sender: linux-watchdog-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-watchdog.vger.kernel.org>
X-Mailing-List: linux-watchdog@vger.kernel.org


 Hi,

 I'd like to improve wdctl(8) to read watchdog info from /sys, but I
 found that sysfs does not provide all information like ioctl API.

 Unfortunately, there is no way how from /sys get info about supported
 watchdog features and firmware version. This info is accessible only 
 by WDIOC_GETSUPPORT ioclt (struct watchdog_info->options and
 watchdog_info->firmware_version).

 It would be nice to have "options" and "firmware_version" also in in
 sysfs. Please :-)

    Karel
-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
