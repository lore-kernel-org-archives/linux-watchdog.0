Return-Path: <SRS0=e0s2=AY=vger.kernel.org=linux-watchdog-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F94AC4345B
	for <linux-watchdog@archiver.kernel.org>; Mon, 13 Jul 2020 13:30:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 65D6220663
	for <linux-watchdog@archiver.kernel.org>; Mon, 13 Jul 2020 13:30:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="L3GiHo57"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729929AbgGMNaQ (ORCPT
        <rfc822;linux-watchdog@archiver.kernel.org>);
        Mon, 13 Jul 2020 09:30:16 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:37096 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729872AbgGMNaQ (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Mon, 13 Jul 2020 09:30:16 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 06DDIRcn107904;
        Mon, 13 Jul 2020 08:18:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1594646307;
        bh=vDYTJdlQIGkfcb4NmcR3M+BY6s+3zPSvoTcXWTkRYO8=;
        h=From:To:CC:Subject:Date;
        b=L3GiHo57doi3Xrobldmnjn2eVXiZXbP72dH1vecfGeUz8V4V/nyzxU/kLuRKar/O0
         AwMn86us8OWTDeicTmriBdXnFpMumgNmH/mdMfhUQRTlsPFrEhe/dXNoLrLJ8HJMqG
         11aHeFO/e16QRV5hZR5QuX4nobhbgHKonjWquQ2Y=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 06DDIQBZ092021
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 13 Jul 2020 08:18:26 -0500
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Mon, 13
 Jul 2020 08:18:26 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Mon, 13 Jul 2020 08:18:26 -0500
Received: from sokoban.bb.dnainternet.fi (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 06DDIOXo015417;
        Mon, 13 Jul 2020 08:18:25 -0500
From:   Tero Kristo <t-kristo@ti.com>
To:     <wim@linux-watchdog.org>, <linux@roeck-us.net>,
        <linux-watchdog@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <jan.kiszka@siemens.com>
Subject: [PATCHv3 0/4] watchdog: rti: support attach to running timer
Date:   Mon, 13 Jul 2020 16:18:14 +0300
Message-ID: <20200713131818.825-1-t-kristo@ti.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-watchdog-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-watchdog.vger.kernel.org>
X-Mailing-List: linux-watchdog@vger.kernel.org

Hi,

Changes from previous version:

- Documentation changes for patch #2
- Dropped the configurable module parameter for window size
- Merged any needed functionality from old patches #3 and #4 to patch #3
  now
- Added new rti driver internal API for getting remaining milliseconds
  left on the timer

-Tero


--
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
