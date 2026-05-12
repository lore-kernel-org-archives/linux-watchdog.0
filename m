Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC9633C3795;
	Tue, 12 May 2026 16:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778602980; cv=none; b=FsKHr9g2ih1f9TiiPd+hmLANEW+Eid5O+0XMhUN/86iGce93cE3hJtXVSyleFW8CNFtHRWT9JY6cc3dxqEJA0RVLpDvbqvPWybR0aGY1HCledW/UENhiASD5NL404TOW6YduNOjrIMysO6mJ12YuYNjy7Wm7y0ZwEyAJXTjuqCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778602980; c=relaxed/simple;
	bh=YE7dchAqARIMwgX2gttgmgzWSc3euZPgGb+LGBUtwq8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=GsQC56m/u0OcKoOeNEKE18LC06Rt8IKCMKEaKKCQb546yQI+UOsEiTLaMdYQ2RKyO0DGt1zs5MFNta2oJV5sHFZAI/0VeAbCGg/itRbwDsrfIzYdIznlAU1JWxHhXTK99K2KURaNU9GO66wxuMKhdtsOY66gbISEijqIkhUHJWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b6mILClX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b6mILClX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3ECECC2BCB0;
	Tue, 12 May 2026 16:22:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778602980;
	bh=YE7dchAqARIMwgX2gttgmgzWSc3euZPgGb+LGBUtwq8=;
	h=From:To:Cc:Subject:Date:From;
	b=b6mILClX5j5qMy8ZTFmhVPt5GPfnyfcBri1PaDZI1dYjOotj/hYBFsOM3sdCND5Dm
	 b6TuYmVemGZSxuiV3k+GTOzOORXLerDNlbRhlDAYDLOMnHV7yTrxYRtMMKubhHxTPm
	 Qqoq1YUjYv8j4kNEQ5If2MB+7dKYjyJXJX4WBiYtiEVKQCdjs/Szrumyxptos1w7xO
	 xpw2khzbgjZfFNUHeECcxqhO6AGigtLiziR2MRVLB6ggwATd8YUnZk4uJRA6MD6wAO
	 9G1h+sfu0LzomQXf5okRY1XXmhWVIdATtjprbzcMhdC51afkJk1nCi54uTyhL1OpJL
	 6R4KMyleBW0Ig==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Wim Van Sebroeck <wim@linux-watchdog.org>, linux-watchdog@vger.kernel.org,
 Linux ACPI <linux-acpi@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1] watchdog: ni903x_wdt: Check ACPI_COMPANION() against NULL
Date: Tue, 12 May 2026 18:22:57 +0200
Message-ID: <2280455.irdbgypaU6@rafael.j.wysocki>
Organization: Linux Kernel Development
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"

From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

Every platform driver can be forced to match a device that doesn't match
its list of device IDs because of device_match_driver_override(), so
platform drivers that rely on the existence of a device's ACPI companion
object need to verify its presence.

Accordingly, add a requisite ACPI_COMPANION() check against NULL to the
ni903x_wdt watchdog driver.

Fixes: d37ec2fbab55 ("watchdog: ni903x_wdt: Convert to a platform driver")
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/watchdog/ni903x_wdt.c |    7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

--- a/drivers/watchdog/ni903x_wdt.c
+++ b/drivers/watchdog/ni903x_wdt.c
@@ -183,9 +183,14 @@ static int ni903x_acpi_probe(struct plat
 	struct device *dev = &pdev->dev;
 	struct watchdog_device *wdd;
 	struct ni903x_wdt *wdt;
+	acpi_handle handle;
 	acpi_status status;
 	int ret;
 
+	handle = ACPI_HANDLE(dev);
+	if (!handle)
+		return -ENODEV;
+
 	wdt = devm_kzalloc(dev, sizeof(*wdt), GFP_KERNEL);
 	if (!wdt)
 		return -ENOMEM;
@@ -193,7 +198,7 @@ static int ni903x_acpi_probe(struct plat
 	platform_set_drvdata(pdev, wdt);
 	wdt->dev = dev;
 
-	status = acpi_walk_resources(ACPI_HANDLE(dev), METHOD_NAME__CRS,
+	status = acpi_walk_resources(handle, METHOD_NAME__CRS,
 				     ni903x_resources, wdt);
 	if (ACPI_FAILURE(status) || wdt->io_base == 0) {
 		dev_err(dev, "failed to get resources\n");



