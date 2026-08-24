Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 189353E4504;
	Mon, 24 Aug 2026 07:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787554818; cv=none; b=jyVsULspnJDGXwTEXQc9k2w/9va6JbYKP0WTq604/+VRujb/X0XbsmlyTW5U/7xblbHaitbUdpPaDLyJPLNLzvi9LT9KO/q+t7C7chssKPkVZd3F8wMIw9RXGMpLoe91NCsYWshoe+QQbfUYBax1jtAhrIN4Ks1M5dr2dzgLUjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787554818; c=relaxed/simple;
	bh=1BHwu993QqQzZYg0L3BF8ds7oNu8ntXFDIpeIJoDy6c=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Afuv+45ZxnxhxApQRxf1sJxZq/spPDO5WU+0VYnHnPiTNujKEZ4mW1s0n24DaR4ifdgQP9v7V49y33L0jboVVm91CUkhnpkuOuyZ9wvgd+iuDJO8q+C8j3rSYKgO0gqCdZR708mbTl66YAKeFu2/ntQLdHZrS8AFR+sF6iN+FuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mwGKXLY8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mwGKXLY8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E4E81F000E9;
	Mon, 24 Aug 2026 07:00:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787554811;
	bh=1BHwu993QqQzZYg0L3BF8ds7oNu8ntXFDIpeIJoDy6c=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mwGKXLY8qhnHrvkmHE6ZbczImldxfM+UiPnbmQdX/T472edanmRLWE9U+gHsd9tAW
	 sFhRw4Daw2/8qXJqQ6W3xem9BKJYsD15YnwX8K4HAOjrorlcBTPQNmrEq5YxTOZeIw
	 n4Ed4U1JgzA2toFKg4Q7v8k27LWj3Nl8YEQBrzVVSeN1PvkzW+SPwun1GTuMxeSFtO
	 Zq/sI16EcuLIHuqxAZwfCLLQ+nkzAxREvc6xXuQ+OTkr5Z2ilYR+b5kiLtyu8CGmZH
	 ebkaVjEvUKdE/vxxVU8EYfKlkQ/vCCJrVWP5JzTuqBr3KIBecbvmvi3iJYLAu41mTw
	 Tk+OzqW0r+iTQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/4] dt-bindings: rtc: Add NXP PCF8525 RTC
Reply-To: sashiko-reviews@lists.linux.dev
To: "Shiv Prakash Gupta" <shivprakash.gupta@nxp.com>
Cc: linux-hwmon@vger.kernel.org, robh@kernel.org, devicetree@vger.kernel.org, linux-watchdog@vger.kernel.org, "Alexandre
 Belloni" <alexandre.belloni@bootlin.com>, conor+dt@kernel.org, linux-rtc@vger.kernel.org
In-Reply-To: <20260824065531.693701-2-shivprakash.gupta@nxp.com>
References: <20260824065531.693701-1-shivprakash.gupta@nxp.com>
 <20260824065531.693701-2-shivprakash.gupta@nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 24 Aug 2026 07:00:10 +0000
Message-Id: <20260824070011.5E4E81F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>

> Add a Devicetree binding for the NXP PCF8525 I2C RTC. Describe the
> optional INTA interrupt used for RTC alarm and timestamp events, and
> the INTB interrupt used by the watchdog.
>=20
> Add properties to select the external crystal load capacitance and
> temperature-compensation crystal model. Also allow the common
> start-year, wakeup-source and reset-source properties, with
> reset-source enabling watchdog registration
>=20
> Signed-off-by: Lakshay Piplani <lakshay.piplani@nxp.com>
> Signed-off-by: Shiv Prakash Gupta <shivprakash.gupta@nxp.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260824065531.6937=
01-1-shivprakash.gupta@nxp.com?part=3D1

