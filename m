Return-Path: <SRS0=7ngW=PM=vger.kernel.org=linux-watchdog-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C237C43387
	for <linux-watchdog@archiver.kernel.org>; Fri,  4 Jan 2019 06:48:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDB9B21871
	for <linux-watchdog@archiver.kernel.org>; Fri,  4 Jan 2019 06:48:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="wvE5ui46"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726178AbfADGsK (ORCPT
        <rfc822;linux-watchdog@archiver.kernel.org>);
        Fri, 4 Jan 2019 01:48:10 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:60064 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726117AbfADGsK (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Fri, 4 Jan 2019 01:48:10 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id x046cvQo148640;
        Fri, 4 Jan 2019 06:47:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2018-07-02;
 bh=rk4NUtPXAseTSxYEIdypattCOdGYFHKQvziYzVxEvDo=;
 b=wvE5ui46CPrrew87Unn58/gjBnu3Yj5TMZE4uNid1s1K70pdl8EMFOTtB+vPBLaYO3kk
 GRY0gShRM+bQM7ZC+OhkTHrEy13rr3Nut+XSlhANDdw7IpJqEcITVpSjiWUWm8Gq73lm
 XLD4VZuqAapkCFTIehaua+I2mTWqre4Vn8GpcRp2E0vGMtan0Pw3ym7sq/QuPe6iajnx
 SieKYEISppTKfeNj52A604TC9xWgu43nCjozIzxorIUdQBV0TE3NFJMqadgcBNAPUa8b
 EF/uvNxfG+bGnC+xrDuRnd2uQA8N80tB9Q2tFVy9sEq5JfjkDDbERwypzAK5jUzsOL7R LQ== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by userp2120.oracle.com with ESMTP id 2pp1jrakup-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 04 Jan 2019 06:47:40 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id x046lYWN030940
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 4 Jan 2019 06:47:35 GMT
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x046lWGh014801;
        Fri, 4 Jan 2019 06:47:33 GMT
Received: from kadam (/41.202.241.42)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 03 Jan 2019 22:47:32 -0800
Date:   Fri, 4 Jan 2019 09:47:25 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Andrew Lunn <andrew@lunn.ch>
Cc:     Guenter Roeck <linux@roeck-us.net>, linux-watchdog@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: [PATCH] watchdog: tqmx86: Fix a couple IS_ERR() vs NULL bugs
Message-ID: <20190104064725.GC30627@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9125 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1901040059
Sender: linux-watchdog-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-watchdog.vger.kernel.org>
X-Mailing-List: linux-watchdog@vger.kernel.org

These functions return NULL on error but we accidentally check
for IS_ERR() instead.

Fixes: e3c21e088f89 ("watchdog: tqmx86: Add watchdog driver for the IO controller")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/watchdog/tqmx86_wdt.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/watchdog/tqmx86_wdt.c b/drivers/watchdog/tqmx86_wdt.c
index 0d3a0fbbd7a5..52941207a12a 100644
--- a/drivers/watchdog/tqmx86_wdt.c
+++ b/drivers/watchdog/tqmx86_wdt.c
@@ -79,13 +79,13 @@ static int tqmx86_wdt_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	res = platform_get_resource(pdev, IORESOURCE_IO, 0);
-	if (IS_ERR(res))
-		return PTR_ERR(res);
+	if (!res)
+		return -ENODEV;
 
 	priv->io_base = devm_ioport_map(&pdev->dev, res->start,
 					resource_size(res));
-	if (IS_ERR(priv->io_base))
-		return PTR_ERR(priv->io_base);
+	if (!priv->io_base)
+		return -ENOMEM;
 
 	watchdog_set_drvdata(&priv->wdd, priv);
 
-- 
2.17.1

