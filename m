Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794776086;
	b=h532RZjdKPASJmu68z/JCfEPaqOGklMS/akoYgos67gS8jrHvTnnRi6BbYPdkBjufiXI
	 5mRtyNXHBnNBPBlZJYC7Xa/MTQRKrn4MovmyYibPcJO0H/5YZVhxSSaRzThrO711W2YKN
	 U+xnArICTvKHghtEr3BiBUKSGYrQJqxqFVljavL1h6e9Vh1a8ypoM1G+ZMV2rxydI7yHq
	 g8Efga/a8ZTuo/SJPo7ymjx2FEjAjyL5JRHSKV1vfMXzeaYQA7gZNIPFjl9+Od51cs4CR
	 hD5B3ZYo3muqGrE0RXZV8dkOJWogokF0sBmpkHMKIZ59CtpWhuCRBZoCmFUw0UoZF1A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794776086;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=6ClDD9nTGI8hAvNqlaRIKaFnhjgHLTyJoI/75ad2iX8=;
	b=JCjP6gc//t1vAf3yhl7TQGSdgkj5OJs/qsgT/N25VDaKx+t4P7k+A3SptyMXydypnCeH
	 8tqevszxVYd6F9imfcpQHnmruMusifYxEE11tLCIHfSQbWQ4yc/243IG70jGM3t37Uf/s
	 l6ZugKjPog+5BT/QJm0KihIkqPxpH25P0NQUgBdzMdHjycI0klltzWLK/Qs9OIHN+gKOu
	 2+Vack8eMkUOwfUBAuCc6o85Hrk6vmUqhOeO0wEM1VN9WuyojVs00u3qsiyyEISpYjSzQ
	 SHQG+fWu1dyPHVAb6iBKOjpLP0i1L41caWFcHoIR5u7pqOY0YZK+h7kZFboYb7LOvsw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=EjyVrJEz;
	arc=none smtp.remote-ip=209.85.128.42
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 772FD606A32F
	for <linux-watchdog@vger.kernel.org>; Sun, 15 Nov 2026 20:54:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 772FD606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=EjyVrJEz
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4a2072b9832so20449575e9.1
        for <linux-watchdog@vger.kernel.org>; Sun, 15 Nov 2026 12:54:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794776085; x=1795380885; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6ClDD9nTGI8hAvNqlaRIKaFnhjgHLTyJoI/75ad2iX8=;
        b=EjyVrJEzFNkDD46WNnL0gi3OzH8k7BOw17Yf3imQIMoTvBHzP1HoVjHg9lFlrX0Ftl
         UVfT6DYn6kkh2FRYuHV3iQYhJM2GJ7jk4IjqGgZ17iyAocxQ4AtPIeZvYBMLhJruD76b
         kAj0RA35yWsF5WgGEUiDepFRHcP0a7zBHenVSwNOe4dzrUtzW2wxz9elIE9KWJgSMcKW
         SDWcKafy9Woe1WHwgKeinxT5pDv+pj6MVFfKB3BxP/ls76PGSYeh30Tg2ouUq+TgR6PW
         5leot3ekyGK6cxLOve5IkagHWd3YHUW1JJaIeaJtRIVR0pHGh17SNRx5uPlVXJbzcQwr
         CqIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794776085; x=1795380885;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=6ClDD9nTGI8hAvNqlaRIKaFnhjgHLTyJoI/75ad2iX8=;
        b=2k8g3E+9ajqCipp5uCbfLm81DZ1gtTsp7hM+18PyKk+Ys61m9DE7cl99BfkImEVfrg
         L8FJRM2IVjV910Qqnj1zLXBCJvsv99UZlfCTGQDYqJdGansHBj+hKYSGThFExsJVYd6k
         m3ep19XuxR88/qusGR364Obph/wEotJId+VZ4Yztc1a1BZJRThQqHXgU/qYBUZDW66T2
         hsxVVRr+IRSIKdHo/6KJZo2hpbWIzhg051QvZVLPwiQqbVLcWaEiJoiPDoIYn9/V92tr
         w13NVPS0ifXf6X9pDj9K0N4OGKiJLokHOHiKpaBXppD/NGaW9tGQ04Ih+JwVf1IwZUr2
         3klw==
X-Forwarded-Encrypted: i=1; AL+hErEQhS+R1stAZ1rrjHbCaialnla6GKbve7mNuk9JoFA8d2ynnxld8FWk1QgM7zZvzG9P3KBsL6Pj21SyhFIOKA==@vger.kernel.org
X-Gm-Message-State: APuU4Z9C9LVkMHvgmPWoiohflx8V+KWp2kdmV2iGf2/xcziJohks4tLY
	KrioP300yrJvvOt5WBV15UW8zANvv5aauchmz2zoQ5Cwqa+duM01rrNpJEr7xjKQk2k=
X-Gm-Gg: AYBFou0a5A1xPjBLuWI3bAucYSj1H1fWQsFLGk+BKbJHqI/Lo4t6NVHjc4E1avse8An
	4QYYRAHWoRtm9pqV+uaN8EYCXrQreTgWFKHGJDnV+asyC0WRo6y77GXXbCUmniMEfYH/f2uD6pm
	a+Iwq0k01uPK43YgXFPVvDJZmQsUtdLc25q0o9nuxv8Bd+e9pUrm8JFrw0w5bEzMIA+vO9NUJEW
	+F8h2BLYcUMGy8XUAXyB9Ve8gPGIsnN2XVTcqSLrKYoAiMS+9XUaQjdu+ycU539aBZholRVxflt
	5RYcQmNY1ndkOeaihoaPGgg+AtEUbu2NTA2ETjfSA1t2rFCNp/e3/nIkX9ce8IoYdw9y0Zs2GrG
	YqbkHFHmadAcHCspemo3utS6ss/H8+gWV5dfxDlIUQVvGpe1jHb7awZutAz/SWoza+gF0Skgykn
	Gu4SAmriv07vBpbsElta/dTtE2JPUoQLdTkFqFi+v/27h/qKaLVy+AAAN8aGRkh80fAEjCShi3n
	m74ruUy5IiCxbg9dePNMujBHHWFj7LttRVXlc2fYzAqlZZH5iK7xjhVwTVZV5veA7GwJOJKBa80
	1KnyA1dAq9nf+vM+7cODJyUWdYirPvd2mxex/P0okM1mr3OC9uokehhsPsdpASfRS0XNnm6tMPU
	cKU80BFLR
X-Received: by 2002:a05:600c:4504:b0:49e:6581:7baf with SMTP id 5b1f17b1804b1-4bb559f044amr178097035e9.2.1794776084425;
        Sun, 15 Nov 2026 12:54:44 -0800 (PST)
Received: from localhost (bl20-90-91.dsl.telepac.pt. [2.81.90.91])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb55ae5299sm251713855e9.11.2026.11.15.12.54.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Nov 2026 12:54:44 -0800 (PST)
From: =?UTF-8?q?V=C3=ADtor=20Hugo=20Silva?= <vitorhg20080@gmail.com>
To: Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>
Cc: Diogo Ivo <diogo.ivo@siemens.com>,
	linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] watchdog: intel_oc_wdt: Add INTC109C ACPI ID
Date: Sun, 15 Nov 2026 20:54:08 +0000
Message-ID: <20261115205408.99849-1-vitorhg20080@gmail.com>
X-Mailer: git-send-email 2.56.1
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Post: <mailto:linux-watchdog@vger.kernel.org>
List-Help: <mailto:linux-watchdog+help@vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-watchdog+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The Lenovo laptops with an Intel Core 7 240H (Raptor Lake)
exposes its OC watchdog as 'INTC109C', leaving the device
unbound, because this ID is not present from the driver's
ACPI intel_oc_wdt_match table.

The firmware selects INTC109C or the already supported
INTC1099 from the same CWDT object's _HID method,
depending on the processor signature. Both paths share a
four-byte I/O resource at PMBS + 0x54.

Add INTC109C to the match table to use the existing implementation.

I have tested as a module on Fedora kernel 7.3.3-300.fc45.x86_64.
I did verify device binding, timeout configuration, start,
keepalive, explicit stop and magic close. Register reads
confirmed the enable and timeout fields. Expiry-triggered
reset was not tested.

AI assistance was used for development of the test harness
and 'peer-review' the patch.

Signed-off-by: Vítor Hugo Silva <vitorhg20080@gmail.com>
---
 drivers/watchdog/intel_oc_wdt.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/watchdog/intel_oc_wdt.c b/drivers/watchdog/intel_oc_wdt.c
index 0b012aeb1..a78fe1e5f 100644
--- a/drivers/watchdog/intel_oc_wdt.c
+++ b/drivers/watchdog/intel_oc_wdt.c
@@ -215,6 +215,7 @@ static int intel_oc_wdt_probe(struct platform_device *pdev)
 static const struct acpi_device_id intel_oc_wdt_match[] = {
 	{ "INT3F0D" },
 	{ "INTC1099" },
+	{ "INTC109C" },
 	{ },
 };
 MODULE_DEVICE_TABLE(acpi, intel_oc_wdt_match);

base-commit: 97d73c8251226cf27cc6656b4c542869bb8c69fa
-- 
2.56.1

