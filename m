Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4C313CC7CC;
	Tue, 13 Oct 2026 05:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.203.200.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791870874; cv=pass; b=VvvyL8Qc0/bd99aMneEie2p1S5bmuPuEyGGjZUlsi3wt6wylywIMSfTpQFAjGlqh82PMHHAOwyeqGdgSsZJJFewguRrTLFfC3dH+SHpsjK5NluVzzYwiH+an3QBTkcgTsDmz2jp9tRoY4MjaGkFUPViKxhGP7ZMdsyxLjVYWZ+U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791870874; c=relaxed/simple;
	bh=cwmt1Rmw7srtXzLyuJulB26D/kRcw+JO8RqDjoEGx30=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=SqR5v2wlIhTwrma+UXcEQy9H7PoVKXr1O4eohdBcK/jMbytHnkcEiOQEs8I4MfIBg0BSlxAym7pdFGU4C7zeN09ch3p5YU0mpx5zML1/2C2dBfnQm7SFB4PBlP/ivUQKBPzDGGci+jiwkV7VVgQSvDAsbPBbzRNoDRXlrfACT8w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b=Gr5V0BUf; arc=pass smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b="Gr5V0BUf"
Received: from ratatoskr.trumtrar.info (unknown [IPv6:2a00:1f:f805:2b01:a03:2f4:308a:7b52])
	(Authenticated sender: str@pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 8FA0D200758;
	Tue, 13 Oct 2026 07:54:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1791870869;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=8tEDT9qAsHJuw08pDh4AzesIHhDXjObjcYV+JFO2mf8=;
	b=Gr5V0BUfZWRlcRLOcI7PDjYnjRtI82+/Cq51cdKsBqeQmSEIqPVInf5EJhxxV3PtIMPTu4
	jvjsOj7KMq+PmCP/aA77vUAjbtYAkYRgLzWkXJSqnX2iEHGCEdAjFBWBWKhAleHPuCmWNP
	gX/gcj9ivrV6y+llJUVTBxJCJeCYqxxrDe1q7aAAR6U2JsDwB4Jre1/5wYz7l/9puPwmIP
	OIvDFY/PXxslwA4QWWxWkzi+UpXknLqhMrGPWu9ZbK6LZLyif3/0epa2dzA4VeFxrzJpFF
	0WEvFAslYFy2LtkKhc0juIprPt8JCz+sDmdmCqbAtki+09/6W5kc8AZjZJCKjQ==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1791870869; a=rsa-sha256;
	cv=none;
	b=Yepv/7LG9g6PjkrZET4sr2+ibpoLnE3DcU6r8+LJFCha1Gvvim43grxL6rivoWkDjbB5Ff
	xxkoUhskIbrBficZMzsD2uRHhSUqhRXcrBBfdDDD3R/y/eKrJRKym5nRkfbMLXp2dBP9pL
	BT+y+KR4l1ecK2RYT5mBr14lsFVrYz+r7HgQ240bFP3ivDTeeYMlsCNeD42E9y40xapLPk
	RtgJ9KftHgucbQd1u6hnI3N7Y0XehOw1bYk5tpHfT0DcM2JmXahniZAd56dkpafp6AaUfD
	H3iAW6Koet6BGV5qN750dHwAmmM+wz7rtAw1aCe8dGVV67E1dWvAzHUgSWN5ng==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=str@pengutronix.de smtp.mailfrom=s.trumtrar@pengutronix.de
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1791870869;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=8tEDT9qAsHJuw08pDh4AzesIHhDXjObjcYV+JFO2mf8=;
	b=aV1NIFI/I2BqZ5Ny6ckdNfTAHITvGn8cKHv5HfJ9BEMmR8fiynEcT+13d3cC2gZb5i1LEt
	yxAOXtp3r39gKkblyRgTHCCjw4728nkwQhUqJrZ59fn543vPGfFYH31t0DWIFKyfif56dh
	p5DYXl89V69NJaBP1vT8yzPCBOVmcCP7jGb5oP8CB9g9GwpgvtWlbWCXJNE5yp8b+XRmM0
	cz3QXElzWZuGNWTDuJ6VqGRsYGB6GwDRZ/2YaFuu4Vau/5Ex3xEXbQBPJ3pYRiRXpXXwfp
	Ghf1Ka5SUsD7ajpzbonRP5uNqgGB5cwbK0iU10UG0XkqPznFyOfioRqH0p8xwg==
From: Steffen Trumtrar <s.trumtrar@pengutronix.de>
Subject: [PATCH 0/2] watchdog: gpio_wdt: add reset-from-wdt status gpio
Date: Tue, 13 Oct 2026 07:54:26 +0200
Message-Id: <20261013-v7-3-topic-gpio-wdt-v1-0-bc98f05a4578@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMTQ6DIBBA4auYWTsJTE0xvUrjwuJgpwshgD+J8
 e5SXX6L93ZIHIUTvKodIi+SxE8Fuq7AfvtpZJShGEjRUytNuBh8YPZBLI5BPK5DRtOavmmdU0Q
 WShkiO9mu67u7nebPj23+r+A4TmipUBx3AAAA
X-Change-ID: 20261012-v7-3-topic-gpio-wdt-787a48ff022c
To: Wim Van Sebroeck <wim@linux-watchdog.org>, 
 Guenter Roeck <linux@roeck-us.net>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Robert Marko <robert.marko@sartura.hr>
Cc: linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Steffen Trumtrar <s.trumtrar@pengutronix.de>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=873;
 i=s.trumtrar@pengutronix.de; h=from:subject:message-id;
 bh=cwmt1Rmw7srtXzLyuJulB26D/kRcw+JO8RqDjoEGx30=;
 b=owGbwMvMwCUmtVehiCsuTInxtFoSQ9bZ41PKF+yr+6Yh/sLpyDK9p3a5Cr9366VLLD6zImObc
 cVUrYfXOkpZGMS4GGTFFFlUFlbwiXp88IycJsIFM4eVCWQIAxenAEzkUD4jw7lmhh+yc7r9pCuX
 qza9rThxgbE+/ZlTwL/cudGzFRpn1jAyfPiSHtX8YKHt/Jr4K5s8r8oFn7KsmBexYOU0C+Xw59e
 bOQA=
X-Developer-Key: i=s.trumtrar@pengutronix.de; a=openpgp;
 fpr=24A1780E1548F0495996140A1ABD20720A5E5622

In cases where the wdt-gpio buffers the reset signal over a reboot, this
can be used to decide if the watchdog caused the reset. Watchdogs have
the bootstatus for this information.

Add a device-tree binding for this gpio and evaluate the gpio in the
driver and set bootstatus accordingly.

Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
---
Steffen Trumtrar (2):
      dt-bindings: watchdog: add reset-from-wdt-gpios binding
      watchdog: gpio: add reset-from-wdt support

 .../devicetree/bindings/watchdog/linux,wdt-gpio.yaml      |  5 +++++
 drivers/watchdog/gpio_wdt.c                               | 15 +++++++++++++++
 2 files changed, 20 insertions(+)
---
base-commit: cee9395acd8043be0644b25c34bfa86623f2b935
change-id: 20261012-v7-3-topic-gpio-wdt-787a48ff022c

Best regards,
--  
Steffen Trumtrar <s.trumtrar@pengutronix.de>

