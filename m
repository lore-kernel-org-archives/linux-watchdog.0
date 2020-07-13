Return-Path: <SRS0=e0s2=AY=vger.kernel.org=linux-watchdog-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7264AC433E0
	for <linux-watchdog@archiver.kernel.org>; Mon, 13 Jul 2020 05:54:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 51D4C2073A
	for <linux-watchdog@archiver.kernel.org>; Mon, 13 Jul 2020 05:54:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725920AbgGMFyF (ORCPT
        <rfc822;linux-watchdog@archiver.kernel.org>);
        Mon, 13 Jul 2020 01:54:05 -0400
Received: from smtp25.cstnet.cn ([159.226.251.25]:35092 "EHLO cstnet.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725818AbgGMFyF (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Mon, 13 Jul 2020 01:54:05 -0400
Received: from localhost (unknown [159.226.5.99])
        by APP-05 (Coremail) with SMTP id zQCowABXng7v9gtffydiAA--.31846S2;
        Mon, 13 Jul 2020 13:53:51 +0800 (CST)
From:   Xu Wang <vulab@iscas.ac.cn>
To:     wim@linux-watchdog.org, linux@roeck-us.net,
        linux-watchdog@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Xu Wang <vulab@iscas.ac.cn>
Subject: [PATCH] watchdog: pcwd_usb: remove needless check before usb_free_coherent()
Date:   Mon, 13 Jul 2020 05:53:48 +0000
Message-Id: <20200713055348.21620-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: zQCowABXng7v9gtffydiAA--.31846S2
X-Coremail-Antispam: 1UD129KBjvdXoWrZw4rtr4rZr45AF15Aw1UZFb_yoWfuFc_Jr
        y0qrZ3GrnxCr1SgFy8Zw13AFWqgr48XFn3Wr4ftFyrCFZrtw1Yyr4xArWfCr4fAa95J3y7
        Gr1vqrWFkr18GjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbcAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2IYs7xG
        6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
        A2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_
        Cr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
        0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
        jxv20xvE14v26r1Y6r17McIj6I8E87Iv67AKxVW8Jr0_Cr1UMcvjeVCFs4IE7xkEbVWUJV
        W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc2xSY4AK67AK6r4r
        MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr
        0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0E
        wIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJV
        W8JwCI42IY6xAIw20EY4v20xvaj40_WFyUJVCq3wCI42IY6I8E87Iv67AKxVWUJVW8JwCI
        42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUY1v3UUUUU
X-Originating-IP: [159.226.5.99]
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiCAAQA18J9e7lagAAsZ
Sender: linux-watchdog-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-watchdog.vger.kernel.org>
X-Mailing-List: linux-watchdog@vger.kernel.org

usb_free_coherent() is safe with NULL usb_pcwd->intr_buffer and 
this check is not required.

Signed-off-by: Xu Wang <vulab@iscas.ac.cn>
---
 drivers/watchdog/pcwd_usb.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/watchdog/pcwd_usb.c b/drivers/watchdog/pcwd_usb.c
index 2f44af1831d0..6726301ac02e 100644
--- a/drivers/watchdog/pcwd_usb.c
+++ b/drivers/watchdog/pcwd_usb.c
@@ -585,9 +585,8 @@ static struct notifier_block usb_pcwd_notifier = {
 static inline void usb_pcwd_delete(struct usb_pcwd_private *usb_pcwd)
 {
 	usb_free_urb(usb_pcwd->intr_urb);
-	if (usb_pcwd->intr_buffer != NULL)
-		usb_free_coherent(usb_pcwd->udev, usb_pcwd->intr_size,
-				  usb_pcwd->intr_buffer, usb_pcwd->intr_dma);
+	usb_free_coherent(usb_pcwd->udev, usb_pcwd->intr_size,
+			  usb_pcwd->intr_buffer, usb_pcwd->intr_dma);
 	kfree(usb_pcwd);
 }
 
-- 
2.17.1

