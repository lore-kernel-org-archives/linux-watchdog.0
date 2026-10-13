Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4B973B7753;
	Tue, 13 Oct 2026 05:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.203.200.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791870875; cv=pass; b=Muc2AiFEXpqbsXmTijEqSJNX170iWF9RQUakhU4r09UY9zwbibiEoY4yMO01jVjwTJj/D0uCSoCTdszeXLBSqsxBTmADlxCYDj20JkwmiBOZVTNGo5wPeWHrYXBmoT+cupz270kYZY6fCFSwey/uIjoVNrvvqgQKDk+RAzSnrJs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791870875; c=relaxed/simple;
	bh=DushuvMwmmaDO+B3Ot5rfR9WnnEu6r195kI7IiNDm8o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XjUWloG4GtTQgQaEejTn0YVkD5VOb/SCfHIDJz8hmcQj1KCjhoMHUHVK2a3zvrc9Td2Ovbk/txpy9p+LQGfutVvWngbp+ncR9NawxM9OwV2ywEc1K9CrFJXEEXlziiqdklgUQmNEVsqdSBY5amxEEtsjrobyahrQt7dLEYkT6xE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b=EjM1XyFE; arc=pass smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b="EjM1XyFE"
Received: from ratatoskr.trumtrar.info (unknown [IPv6:2a00:1f:f805:2b01:a03:2f4:308a:7b52])
	(Authenticated sender: str@pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id CD6DE201EAF;
	Tue, 13 Oct 2026 07:54:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1791870870;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=O6lvayQ0nf4sRzcz8XhZ8L2OjUC7e2whxY0cfF549M0=;
	b=EjM1XyFEzffJW4jOnrPC1qWwOqMGEbiVZ4U4ShFatYNuLv4GbSFjxyFMRZYH8rF0GPjRMV
	mCVfiaYHVLxUv/joFf5TxpjBi8eU2Ap8gpL0mU1V3CZbwX4op02PigharvtePUEON77RrG
	4rRr6JD/fkVRz82ftiqYcO2LQKVdP2aOseBSuKyrlXcyD5BXNuxIs5XN9NG+N7eV2sI4wY
	OK+uU5EBUZNEL+4mK8fw4Vu4Y3pzhVRNcwxNHzT5fJVyiCBpPxXig0lwN9QwohTcotJNz0
	xG9RRIn2Dig72D/sInIVpD7O8KF1gpDa1napWPoYm1RcQjWqA+x2TUhVY2gxeQ==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1791870870; a=rsa-sha256;
	cv=none;
	b=B8YEAgfP65V6PdUxxf42jznwDrlAA4s93ACpMxYRxw3Zsi+NMixENgqi7xTdmsJBsH9qTm
	vN8gTSsMg3xmnCa32TXx1Iy2TeSVDTw8RykAgeaIl9znbr7h3AaXKYkm9So4xZx/Xh0N1C
	xp10hVQqgUaUmhyUNlzyq/Qlcmhz/eU61rCp8IBe3AAA672DLeNbos3JgfHKRM58xyf7mS
	P1xtpHmhBG49yFss1l162tG4DmR8PvatwY3FHkuHcj2KXk0RZL12zaKMeRnggcRUl0ubRK
	nrptaotHurZ2wQfNZuVM3VI3EnwZwdbJEO9Cbukx5iAtJwU7tAPzJQlSxno0+Q==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=str@pengutronix.de smtp.mailfrom=s.trumtrar@pengutronix.de
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1791870870;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=O6lvayQ0nf4sRzcz8XhZ8L2OjUC7e2whxY0cfF549M0=;
	b=QJXN6fjEEIQD+EVGr/t/T7hX4LLLKUsjr1EbN6/qsorU4WbE8EMSV5P+GcMfoLTeM0oS9z
	oVxpFkCsZGkubhUfHSR284pa5fYjyna0HQmE5LaHIhs44C4S1UDqkKWCCtW1pIKxoob2bk
	hDiFXPPIoF1/UAW3yBE7coddzL469ry+eCR94kNuAIzjfJKjgdtPz30K5pl9JeWahHxzEm
	VBDeoaD/5aTNwpt/QcT9dtDTrFludP55Fd98kSk7XimX+M6nLQdmHXBdMyc2fDr5+tqsj7
	Y3TaJS/OcLMOkG+zQSMZDSfW5IIGCX/j55of/TFEPTRZGYkF6EJlVIBqndYbZA==
From: Steffen Trumtrar <s.trumtrar@pengutronix.de>
Date: Tue, 13 Oct 2026 07:54:27 +0200
Subject: [PATCH 1/2] dt-bindings: watchdog: add reset-from-wdt-gpios
 binding
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261013-v7-3-topic-gpio-wdt-v1-1-bc98f05a4578@pengutronix.de>
References: <20261013-v7-3-topic-gpio-wdt-v1-0-bc98f05a4578@pengutronix.de>
In-Reply-To: <20261013-v7-3-topic-gpio-wdt-v1-0-bc98f05a4578@pengutronix.de>
To: Wim Van Sebroeck <wim@linux-watchdog.org>, 
 Guenter Roeck <linux@roeck-us.net>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Robert Marko <robert.marko@sartura.hr>
Cc: linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Steffen Trumtrar <s.trumtrar@pengutronix.de>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1059;
 i=s.trumtrar@pengutronix.de; h=from:subject:message-id;
 bh=DushuvMwmmaDO+B3Ot5rfR9WnnEu6r195kI7IiNDm8o=;
 b=owGbwMvMwCUmtVehiCsuTInxtFoSQ9bZ41M/PJTLz3rLa2Ug9156+qaZtyz6k06Gbv39cgPTy
 TKlBC7mjlIWBjEuBlkxRRaVhRV8oh4fPCOniXDBzGFlAhnCwMUpABOpvs7wT+NewSn9iysm8uzX
 s15Ssbxod8iPOZpL0lnKxbmZvGYU1jAy/Je6+kn3p6zoJ2lmh9m9UWKxjV8ylG6n8nDccz4mO+8
 GKwA=
X-Developer-Key: i=s.trumtrar@pengutronix.de; a=openpgp;
 fpr=24A1780E1548F0495996140A1ABD20720A5E5622

A wdt-gpio can buffer the reset signal over the reboot, to signal that the
reset was issued by the watchdog.

Add support for a new gpio 'reset-from-wdt-gpios' that allows reading this
buffered value.

Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
---
 Documentation/devicetree/bindings/watchdog/linux,wdt-gpio.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/watchdog/linux,wdt-gpio.yaml b/Documentation/devicetree/bindings/watchdog/linux,wdt-gpio.yaml
index 499f1b7e03f96..b9b64f938daa7 100644
--- a/Documentation/devicetree/bindings/watchdog/linux,wdt-gpio.yaml
+++ b/Documentation/devicetree/bindings/watchdog/linux,wdt-gpio.yaml
@@ -46,6 +46,11 @@ properties:
       It will only cease to toggle the signal when the device is open and the
       timeout elapsed.
 
+  reset-from-wdt-gpios:
+    description:
+      gpio connection that signals, that the last reset was issued by this watchdog.
+    maxItems: 1
+
 required:
   - compatible
   - gpios

-- 
2.52.0

