Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 258DD442106
	for <linux-watchdog@vger.kernel.org>; Mon,  6 Jul 2026 10:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783332883; cv=none; b=CEn4muMYg2QabuoXhLHGGrUVFClkPYfLIoen007mA2jNscZGAzhwkXF9koFndhePdamWycFZjH6TJ0vEEH0wTNN8DwlnR0eaUkMFxhCUYr1I8zE++D4vcB5R6FWT6pfdjFgg6VQGDZOth3ixx1rjt2LwbsoZ880gNe8hNjySS/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783332883; c=relaxed/simple;
	bh=40Hq06/qxAigeGE9xeNifn7CezPvYqKj5h6SL9blMio=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=LDEk49Nbh7aqgwr+9NVj57vcyTwtXVhdWNabboT6nhOmdas9MMLqnZxLNRvSoLoY8cGmm5mohMB8738S8SMEEzG8iZrWvCTQ1lmW0CNfg0+2w79qGekyjgnBrYuHoejdds1+g/C3XIWeeCSQ4cX46pZFG309YhqNIN0XNFckBvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=AGl4aurD; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="AGl4aurD"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 9F1D91A0E8D
	for <linux-watchdog@vger.kernel.org>; Mon,  6 Jul 2026 10:14:37 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 6D153601A2;
	Mon,  6 Jul 2026 10:14:37 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id AD2F711BB9654;
	Mon,  6 Jul 2026 12:14:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1783332876; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=VxJsaXbZ7RKkQQfugffpgVY3vkRr8wYJY+ZrP4uCWPY=;
	b=AGl4aurD1VMIqkrBpkV7P2+pjHQ5rZUsDqb8QbTqs3HBK1zamT3mQtg9GiW12fKr99sJwi
	tixWjSlw1nqfxRCQ7DSU1QcwJXDhEHsnDwV4bwqi00DaSpQ8eS1cMoP6W/Jn5v9ShPB89/
	/65J99FHLTjP6iKFXVt59GCOy7SMDO+CgIpluEXNTh1PxCv/epxhMZ8+um2t+uHvZlsyLL
	6fyJOyfj7kccfJqi1w1WgsBxkVtDzunhx+cONE5TNTkCMIFahSRgXez2HCUPMLwFzpm3A7
	VSPdtf+B62MtEhh6+gZMSxXeDXLEXQs84LfuCsoVLRs9q11bcC8XkE81rcpUDQ==
From: Paul Louvel <paul.louvel@bootlin.com>
Subject: [PATCH 0/2] watchdog: w83627hf_wdt: Add NCT6126 support and
 improve handling of running watchdog
Date: Mon, 06 Jul 2026 12:14:08 +0200
Message-Id: <20260706-w83627hf_wdt-nct6126d-v1-0-c5b0d51691c6@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMTQ6CMBBA4auQWdOkP3EqXIUYA+1UxkUlbRUTw
 t2tsPwW722QKTFl6JsNEn048ytWqLYBN4/xQYJ9NWipUVp5EevVoLZzuK++iOgKKo1edKNUOAX
 rOoNQ2yVR4O/xHW6n83t6kiv/Gez7D/jdipZ5AAAA
X-Change-ID: 20260705-w83627hf_wdt-nct6126d-9a016bf7c936
To: Wim Van Sebroeck <wim@linux-watchdog.org>, 
 Guenter Roeck <linux@roeck-us.net>
Cc: linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Paul Louvel <paul.louvel@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783332875; l=1143;
 i=paul.louvel@bootlin.com; s=20260313; h=from:subject:message-id;
 bh=40Hq06/qxAigeGE9xeNifn7CezPvYqKj5h6SL9blMio=;
 b=xuV6TAxYcj+AQCVf8RhLMqZl1X5HzgyNlc0lpclnRJLE2IB1ZJyJmU+dpSH7qV1bjaUKBkXDr
 fUaH/7noxefAGxVdbrzU/ZE/jLiHmaUravQGp2mgaf2MjnY5WfL6NrK
X-Developer-Key: i=paul.louvel@bootlin.com; a=ed25519;
 pk=eLW50NT18UAvUT5cAcYf88zNbBCZDLFXuptpyLVhVIU=
X-Last-TLS-Session-Version: TLSv1.3

This series brings two small improvements to the w83627hf_wdt driver.

The first patch adds support for the Nuvoton NCT6126 Super I/O chip. The
NCT6126 is compatible with the existing driver but requires reading the
full 16-bit chip ID, as it shares its high-byte ID with the NCT6116.

The second patch improves the handling of watchdogs that are already
running when the driver probes. Instead of issuing a single keepalive
using the default timeout, it relies on the watchdog core's
WDOG_HW_RUNNING support to automatically maintain the watchdog until
userspace opens the device.

Signed-off-by: Paul Louvel <paul.louvel@bootlin.com>
---
Paul Louvel (2):
      watchdog: w83627hf_wdt: Add support for Nuvoton NCT6126
      watchdog: w83627hf_wdt: Use WDOG_HW_RUNNING for running chip on boot

 drivers/watchdog/w83627hf_wdt.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)
---
base-commit: 028ef9c96e96197026887c0f092424679298aae8
change-id: 20260705-w83627hf_wdt-nct6126d-9a016bf7c936

Best regards,
--  
Paul Louvel, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

