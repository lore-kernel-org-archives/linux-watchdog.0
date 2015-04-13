Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from webbox1416.server-home.net ([77.236.96.61]:49988 "EHLO
	webbox1416.server-home.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932181AbbDMNnD (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 13 Apr 2015 09:43:03 -0400
Received: from imapserver.systec-electronic.com (unknown [212.185.67.146])
	by webbox1416.server-home.net (Postfix) with ESMTPA id 6030627A617
	for <linux-watchdog@vger.kernel.org>; Mon, 13 Apr 2015 15:33:47 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by imapserver.systec-electronic.com (Postfix) with ESMTP id 5949ADA10FC
	for <linux-watchdog@vger.kernel.org>; Mon, 13 Apr 2015 15:33:47 +0200 (CEST)
Received: from imapserver.systec-electronic.com ([127.0.0.1])
	by localhost (imapserver.systec-electronic.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ptiu0DbzHk3Q for <linux-watchdog@vger.kernel.org>;
	Mon, 13 Apr 2015 15:33:45 +0200 (CEST)
Received: from ws-stein.localnet (unknown [192.168.10.142])
	by imapserver.systec-electronic.com (Postfix) with ESMTPA id 849A8DA0AD1
	for <linux-watchdog@vger.kernel.org>; Mon, 13 Apr 2015 15:33:45 +0200 (CEST)
From: Alexander Stein <alexander.stein@systec-electronic.com>
To: linux-watchdog@vger.kernel.org
Subject: watchdog timeout in sub-seconds?
Date: Mon, 13 Apr 2015 15:33:41 +0200
Message-ID: <3042537.C3OUI66IzY@ws-stein>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi,

is there a specific reason that the timeout in the linux watchdog drivers is 
only provided in seconds resolution? What about timeouts in ms area/precision?

Best regards,
Alexander
-- 
Dipl.-Inf. Alexander Stein

SYS TEC electronic GmbH
Am Windrad 2
08468 Heinsdorfergrund
Tel.: 03765 38600-1156
Fax: 03765 38600-4100
Email: alexander.stein@systec-electronic.com
Website: www.systec-electronic.com
 
Managing Director: Dipl.-Phys. Siegmar Schmidt
Commercial registry: Amtsgericht Chemnitz, HRB 28082

