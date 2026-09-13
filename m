Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59B5B3C65FD;
	Sun, 13 Sep 2026 06:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789282145; cv=none; b=GjdmcQOsORlKfDFRN7c9kbSMkPsMlKVgFetVb5rYg4yliKceaTqPb/ZCWZKT4/3thNUKCUGq3fafZugkdkjc9TlzuW8G83BkcmuCwb2F7liOXpUkNy4N+FNTGZ7QuU2SUcvafW4gTzD0kPoUrj/V8WELWn78IFU1voohPbeaKU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789282145; c=relaxed/simple;
	bh=T1uaaID4s/V6hhYV3rlMTF9srdIIuFvB6+fJcJOERGk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AIddgeoVGpOm15hobBkD6wAgeP/HollT2l7Hv8FGXfsn4qXO/IBaauTqqzbrMYGn4xsJaepdsYA+8ID8YVOCZ34vEOQS2EnaX4LT/g6ib7rt88E8C0h2cxcvguBZice2G9idlp48VBAm8KgB2HVdefm9z36gGXYZ8fSzDqWmEn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CsFO5uDp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CsFO5uDp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FE281F000FF;
	Sun, 13 Sep 2026 06:49:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789282143;
	bh=j7w4y/lYzmqnn4gxNDKPEkk5Z6YJ9CMAoR7L0ZH/aEw=;
	h=From:To:Cc:Subject:Date;
	b=CsFO5uDpyAmf+7snIcL7144teIzNlOlG5FdI++7Co4cnMx4OOJFEC42V/VqrQR7Yy
	 VhmgcfXmmKgQB+svI+RxRWNqD34BTXqwokO5DA2ABOPYyTI6pXLWt1fce1vcp0Be8C
	 vhVnaFxniPRsYV3BRaEzMlTP/MuxiTrsOgUZY7rFBwAu+vVsPLxo9Lwj/1jYu4UwL4
	 vWsPE/S9AAsjnIKC8+A6aMH+jhKZGR3qHkByfd9LRsQJO5F0rxgd7og528TnFvPnT7
	 zdCBXZpWnoOlbwSZNNqdtmD4ypkQ5Z21zKLz5ubipJ8BAdq+dcGTr+pT1XbmLcFhyK
	 2AUDiT+h79LqA==
From: Tzung-Bi Shih <tzungbi@kernel.org>
To: Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>
Cc: Baruch Siach <baruch@tkos.co.il>,
	linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	tzungbi@kernel.org
Subject: [PATCH 0/3] watchdog: Avoid division by zero from clk_get_rate()
Date: Sun, 13 Sep 2026 14:48:48 +0800
Message-ID: <20260913064851.8239-1-tzungbi@kernel.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The series is a follow-up of [1].

[1] https://lore.kernel.org/all/2c0b963e-6379-46a4-bae8-92ec2d76f8da@roeck-us.net

Tzung-Bi Shih (3):
  watchdog: digicolor: Avoid division by zero
  watchdog: rtd119x: Avoid division by zero
  watchdog: rzv2h: Avoid division by zero

 drivers/watchdog/digicolor_wdt.c | 13 +++++++++----
 drivers/watchdog/rtd119x_wdt.c   |  7 ++++++-
 drivers/watchdog/rzv2h_wdt.c     |  7 ++++++-
 3 files changed, 21 insertions(+), 6 deletions(-)

-- 
2.53.0

