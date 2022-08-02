Return-Path: <linux-watchdog-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3EF0C3F6B0
	for <linux-watchdog@archiver.kernel.org>; Tue,  2 Aug 2022 12:11:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234668AbiHBMLY (ORCPT
        <rfc822;linux-watchdog@archiver.kernel.org>);
        Tue, 2 Aug 2022 08:11:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233232AbiHBMLX (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Tue, 2 Aug 2022 08:11:23 -0400
Received: from smtpbg.qq.com (biz-43-154-54-12.mail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B77E726125;
        Tue,  2 Aug 2022 05:11:16 -0700 (PDT)
X-QQ-mid: bizesmtp69t1659442272t060c3dy
Received: from kali.lan ( [125.69.43.47])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Tue, 02 Aug 2022 20:11:10 +0800 (CST)
X-QQ-SSF: 01000000002000F0U000B00A0000020
X-QQ-FEAT: IByDngDI/kEULM8eBcnFiowBUiWip0/lZKCIFif3/zYg65ckDmOrcgAn3WbBn
        KP02SzBk9FX8RpXfUhmINvZTkqdYGJl5LKF5M8R5jI7eXS8Ev6bCPotG3DxwIh7MbCA0feX
        wGVR+PHI64ci2x89TRY/7CykQ37uNPH+JEyzJYjHhS2mDaGJW2sKZjylpfKRF6ahfpX/E24
        VPLAJT0djLHWoI+V0qQEKLyB8x/vjS+h6uE7NgawgZ/O4AptR0+iK9cGMUQPVDtIQL1IGt2
        /0UvwCwfUywiqiCNFChuNqlsrXjS0veCGqRGV8mA6ehZZgYUvmzpUU/VFXiWCh5RXC5Lrnp
        u8J5eMoqMhtJWWROpp/zPNDMfeQJhxh0Zom781Uv1fhsw+rNeJAaG/N48AJXDo62Rr9tT4Q
X-QQ-GoodBg: 0
From:   Jason Wang <wangborong@cdjrlc.com>
To:     linux@roeck-us.net
Cc:     wim@linux-watchdog.org, linux-watchdog@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jason Wang <wangborong@cdjrlc.com>
Subject: [PATCH] watchdog: w83977f_wdt: Fix comment typo
Date:   Wed,  3 Aug 2022 04:11:09 +0800
Message-Id: <20220802201109.6843-1-wangborong@cdjrlc.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr6
Precedence: bulk
List-ID: <linux-watchdog.vger.kernel.org>
X-Mailing-List: linux-watchdog@vger.kernel.org

The double `we' is duplicated in the comment, remove one.

Signed-off-by: Jason Wang <wangborong@cdjrlc.com>
---
 drivers/watchdog/w83977f_wdt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/watchdog/w83977f_wdt.c b/drivers/watchdog/w83977f_wdt.c
index fd64ae77780a..31bf21ceaf48 100644
--- a/drivers/watchdog/w83977f_wdt.c
+++ b/drivers/watchdog/w83977f_wdt.c
@@ -321,7 +321,7 @@ static int wdt_release(struct inode *inode, struct file *file)
  *      @ppos: pointer to the position to write. No seeks allowed
  *
  *      A write to a watchdog device is defined as a keepalive signal. Any
- *      write of data will do, as we we don't define content meaning.
+ *      write of data will do, as we don't define content meaning.
  */
 
 static ssize_t wdt_write(struct file *file, const char __user *buf,
-- 
2.35.1


