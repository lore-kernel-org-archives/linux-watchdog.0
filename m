Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793614487;
	b=UBsVijDwx2EzoDQ521BoD+rKv502tJ0tw+X4vyQSaL8kAaVg+TgF9rmqBl8lq4pHUucl
	 H7mDzabnJoq6WvSK9VfUoib8lPOqoCg/ISbGBf2nRqZSoSU8xQUFFxIsUQsfJO1aiLU9D
	 xAldtxFT9YZWntzzKT4RW6VSOglikGRy/xngjDkeH1T0nVPHvVXrzuPwc9hih/mo2/v21
	 7DXLr8cIwpnm105usvJgVzU444tVNQJuWTzP9RNgMQeNGircpnOhBlYth+C2lyruyEY12
	 KC86TKCCqeD+af6wSa1ReUgt1y5wUJFTeUmHmCHpvd/8ydpuZFsY5Nbjnao3bG0U9DQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793614487;
	h=Received:DKIM-Signature:From:To:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer;
	bh=S7XSI/+U+6ivNuzR0geAXKanTAFISUKZFrCD8FXCF0I=;
	b=WqSF2BRiZm+aukzqcqmxQ75H4Ka4h8YP6+6Des5odsoCV4aofk4R49osLnaXNsRUZpO8
	 cMkPaOS9vsKcYfwOB+r/TlenkIp562kvhKIKeWA+wKImNzrzlsCX0zVM7kUfXE9eKHL6+
	 29IZD03XtyE+6UQ0gxdLxPS0NDx2hDNNTV39J0kKNuaLzbPW8zr9CLuDldXcnRAnTRu1q
	 9bKzMo//AsINjCiOxnWiiecLEtHNitBiBMfpy/6amWmEjpMMWv8JU8jnBKqzRKF5cXBeY
	 oMLss1vL79KPZ4BNscqbqG9VDIMKtRqG7rrzU2EWD8b2H8pYiII2v8fLXd4ZzXBxTMw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ng2BDioR;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1600606A338;
	Mon,  2 Nov 2026 10:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ng2BDioR
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE0701F00919;
	Mon,  2 Nov 2026 10:14:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793614487;
	bh=S7XSI/+U+6ivNuzR0geAXKanTAFISUKZFrCD8FXCF0I=;
	h=From:To:In-Reply-To:References:Subject:Date;
	b=ng2BDioR3f9LpTH/zqdww8JTurWyUa0rXijgN1Utkx6SsLWPton9MtnoQebL02NEM
	 RukTASa9Chs6W3brcUiawVszyxkUwH+9zOedZpQBh0w0Y/GHmgp/yx0TOURPaiYRcq
	 oFNc9hhRiDxf+00k4mMOk/ltMGD/sXm0ZaTY7VYACEQ4CJ9kJ8TGGLjB5f1bKJWkUp
	 iUJ8GT2+9GmgwQViFw/TxpQnexYfPqCu0VbXdth7Uhni1etEjDeQ1fzA8lESmh6ftp
	 wfRjKwkB41Up6TRHOTaUi+uWcZkD4sOiGjWeO7/8dML5pw2hb6TUaTLD6wMy3xpDeV
	 6K5Tx6crNd5rA==
From: Lee Jones <lee@kernel.org>
To: Lee Jones <lee@kernel.org>, Guenter Roeck <linux@roeck-us.net>, 
 Wim Van Sebroeck <wim@linux-watchdog.org>, mfd@lists.linux.dev, 
 linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org, 
 linux-watchdog@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
In-Reply-To: <20261030152821.283215-2-krzysztof.kozlowski@oss.qualcomm.com>
References: <20261030152821.283215-2-krzysztof.kozlowski@oss.qualcomm.com>
Subject: Re: (subset) [PATCH] MAINTAINERS: mfd: Drop MEN F21BMC (bouncing
 email)
Message-Id: <179361448552.127624.3807018457471483638.b4-ty@b4>
Date: Mon, 02 Nov 2026 10:14:45 +0000
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Post: <mailto:linux-watchdog@vger.kernel.org>
List-Help: <mailto:linux-watchdog+help@vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-watchdog+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.16-dev-ad80c

On Fri, 30 Oct 2026 16:28:22 +0100, Krzysztof Kozlowski wrote:
> Emails to Andreas Werner bounce ("reason: 550 5.4.1 Recipient address
> rejected: Access denied.), so apparently driver is not supported
> anymore.  Last emails from Andreas Werner are from 2016.  Drop the entry
> completely.

Applied, thanks!

[1/1] MAINTAINERS: mfd: Drop MEN F21BMC (bouncing email)
      commit: f2a695d1020d766ed2b9c2cd53bce989357bc2ba

--
Lee Jones [李琼斯]

