Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CC084477E3;
	Tue, 18 Aug 2026 15:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787067896; cv=none; b=jEQgjZ0ePK3kkxURpGoRckfGMHCaV4c3R0LbrsSjI6A9LIj463CreV8gVQP7EfF7tpZ9SY1xYGod7cQEVzAFvNvwqVSeWh6hzYuxJJJzrXfUyNLeO86TmxJfP3YtAiZa7sAavN/DCOSszi+gjBvlUQ5yNrN8dXVU2sAG+e7RC4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787067896; c=relaxed/simple;
	bh=SYDB7RLaFGzmalX7pF7DTWHF88YLCh1NsTPKm0X9TIc=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=mcVKYbEiTl5KejciBsyZUNllw3sQKTp7DPkzAyX4VaILSKcDx6REpI6AS1vuehat5KKL9JQ6eRFd4CS8ub0YyfffhYJH5pKyk3Jz3pvmRuZerMQp2kGIjl/QquSE8DEzLLYHiICQ7Ve2tQ56n6iUxe36TRVuJSBsmUfjeZk9BEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ePndhqFD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ePndhqFD"
Received: by smtp.kernel.org (Postfix) with ESMTPS id D677CC2BCF4;
	Tue, 18 Aug 2026 15:44:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1787067895;
	bh=SYDB7RLaFGzmalX7pF7DTWHF88YLCh1NsTPKm0X9TIc=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=ePndhqFDR3r9o343oyFiXat5psrA8rZXRNGvTcFO3SFJIYPmBiGpZvQWoLMwaOuXj
	 2z5XS5v9lW/gJyXt3Vd3irq96X5GDrgqLYRRv7VE8moMxZLxdoC0WHFPYwuaSJ/zr7
	 o/A8yGEXeq5vAPzVl2BfBZaEaAoBEsYpC6O9DtKkq5maN+ogNlkJ/PA1oGqiZcGNb7
	 AFkC3huvcE0zQ6g1xTZMCovIlWidd2CKuNZWZRC7gJKCdyaJciNUhD27qzBYGFqYAR
	 2dJUz1C7q+rCgscNPfYJhqtb6IeTlEzUExSuqPI9CFvowFvYDE64RG5ZN6zWyEi5jZ
	 mTtYORuwYjJpA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC334C5DF84;
	Tue, 18 Aug 2026 15:44:55 +0000 (UTC)
From: Aiden Isik via B4 Relay <devnull+aidenisik.member.fsf.org@kernel.org>
Subject: [PATCH v2 0/2] watchdog: Add Exynos5515 watchdog timer support
Date: Tue, 18 Aug 2026 16:44:46 +0100
Message-Id: <20260818-for-next-lucky7-watchdog-v2-0-6743f479a47f@member.fsf.org>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAO59hGoC/3WNwQ6CMBAFf4X07JJuERFP/ofhQMsWqkJNWxBC+
 HcB49HjJO/NzMyTM+TZJZqZo8F4Y7sVxCFiqim7msBUKzPBxYmfMQVtHXQ0Bnj26jFl8C6Daip
 bQyKklilijhrZen850mbc1bfiy76Xd1Jh822Lxvhg3bS3B9x2v0z2PzMgcCjxmGScBJe5uLbUS
 nKx9jq2rmbFsiwfgl9QP9cAAAA=
X-Change-ID: 20260815-for-next-lucky7-watchdog-32bfb51191f1
To: Wim Van Sebroeck <wim@linux-watchdog.org>, 
 Guenter Roeck <linux@roeck-us.net>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Peter Griffin <peter.griffin@linaro.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, linux-watchdog@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
 Aiden Isik <aidenisik@member.fsf.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2085;
 i=aidenisik@member.fsf.org; h=from:subject:message-id;
 bh=SYDB7RLaFGzmalX7pF7DTWHF88YLCh1NsTPKm0X9TIc=;
 b=owEBbQKS/ZANAwAIAUknAbLEetfrAcsmYgBqhH311hQoKuTM7nwPpknEB9ihvqkuF3+VheZj+
 EsTV5PcqoqJAjMEAAEIAB0WIQSDy8UkXGpc3JNbEaVJJwGyxHrX6wUCaoR99QAKCRBJJwGyxHrX
 6z4eD/9eXyKF0DJqetBo23B8WfRHUOBKB4+X7/hv19vm0RV3Dvuw1kY0Agg3ThxG74tfhK0mSNk
 xF5p9EjY4tZkNZkv9YFexrOkX6m0GHdPguYGy8A42Moiy5B9hqFhNZGa4ij9pzuicoeDwyEpcYB
 U1M95XmIFrYKgflyzWblxaEnT0SKe2EBmiql5iIfJz7zpEGxyZQX+knj+Kii7Dhj4N33/2dRxJM
 kghlIQOSPNQhEVh6D7ih6HJPbukUIrdLcYULHtH94c21KEWd+/yrF8hTyDZJNiRvKAJ5gtXezZX
 4DU4MSQePcUJ2CSdiOREQYVUqs/8ucOJmZnZQXb9Oxinvb9V20NK3wa0KkjppBcDvOkWd91uQgR
 coKf3zGywpKU73YGFHhupEo9i3Q1Y+46KlDxuSmh+MkdmB9lyDmIPwbobIy+AWAFcwApDAzdfnJ
 ge4B+huYqITBJ04HBsSed29GbjnMkiOdxDbyLN4aeXsVnJFBuKQ707WV+bThX8lauwf1w4L9NYZ
 3Mn8Q59y10QycOZjELmRptHSuDc7UkZNDZYvooUuVqbHZDhi1NKtLxWct3EQ6eYgzGAwJozM5+/
 API8bqVbCY9FHfTfD855/Crb1Uk/Mpth0eNTa/0PNk4oSRbPmA4eeehBiMRDVFXDLimSrLw9igR
 7oLGmtu/TUg8hlA==
X-Developer-Key: i=aidenisik@member.fsf.org; a=openpgp;
 fpr=83CBC5245C6A5CDC935B11A5492701B2C47AD7EB
X-Endpoint-Received: by B4 Relay for aidenisik@member.fsf.org/default with
 auth_id=956
X-Original-From: Aiden Isik <aidenisik@member.fsf.org>
Reply-To: aidenisik@member.fsf.org

Hi there,

This patchset adds support for the Exynos5515 SoC's watchdog timer
to the S3C2410 watchdog timer driver.

There is one checkpatch warning for this patchset:

> -------------------------------------------------------------------------
> Commit 8f4ec3a9b89b ("watchdog: s3c2410_wdt: Add exynos5515-wdt compatibl
> -------------------------------------------------------------------------
> WARNING: Avoid unnecessary line continuations
> #26: FILE: drivers/watchdog/s3c2410_wdt.c:240:
> +       .quirks = QUIRK_HAS_WTCLRINT_REG | QUIRK_HAS_PMU_MASK_RESET | \

Which seems to be erroneous: this line continuation is necessary
(and is done by every other existing entry).

Signed-off-by: Aiden Isik <aidenisik@member.fsf.org>
---
Changes in v2:
- Add samsung,cluster-index: false to documentation
- Remove SoC comment from documentation
- Correct signed-off-by tag in commits
- Link to v1: https://patch.msgid.link/20260817-for-next-lucky7-watchdog-v1-0-a14370e20b92@member.fsf.org

To: Wim Van Sebroeck <wim@linux-watchdog.org>
To: Guenter Roeck <linux@roeck-us.net>
To: Rob Herring <robh@kernel.org>
To: Krzysztof Kozlowski <krzk+dt@kernel.org>
To: Conor Dooley <conor+dt@kernel.org>
To: Peter Griffin <peter.griffin@linaro.org>
To: Alim Akhtar <alim.akhtar@samsung.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>
Cc: linux-watchdog@vger.kernel.org
Cc: devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-samsung-soc@vger.kernel.org

---
Aiden Isik (2):
      dt-bindings: watchdog: samsung-wdt: Add exynos5515-wdt compatible
      watchdog: s3c2410_wdt: Add exynos5515-wdt compatible data

 .../devicetree/bindings/watchdog/samsung-wdt.yaml  | 23 +++++++++++++++++++++-
 drivers/watchdog/s3c2410_wdt.c                     | 12 +++++++++++
 2 files changed, 34 insertions(+), 1 deletion(-)
---
base-commit: acde40ba506aae78633e080b5704d33cf4bc13c6
change-id: 20260815-for-next-lucky7-watchdog-32bfb51191f1

Best regards,
--  
Aiden Isik <aidenisik@member.fsf.org>


