Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 751623502A7;
	Fri, 25 Sep 2026 07:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790322512; cv=none; b=ISmEN8CevF7/KYmnokAapawvG2sfgQo7kDm2RpMw0/Iv0xvUc1e4LxqX5PiSqBmTGS1E4rSvoOmzK+J9MTTOL+g5mGTnXMwdoA/nP11muxKOw7wv+Otr5u7QUDeW/vBSPMTCzuff7cc6DbHEIGxXsIBx92eUb5DvVpcMFp17Q24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790322512; c=relaxed/simple;
	bh=PTAwcF7W/BRk6DQTw6WlVl/zxgxwhhCprqpxWMy1fdY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uAzjaErwzAx6dKhKt3pzyg1Ltwz4F02sr34tcoJJiNZdNRXQwySjutry00dpM/70TVUhNIF6TYnjbdmnqviKG9sfqi59Ny1GhigSE6fpipOqMNlKBqmMOTiPhcOcDb3AkPYXuv6sAzr/Zxlztgo6jkVQZTV8YMgib5xAuUnlosw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EmM9nHBJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EmM9nHBJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29E811F0089A;
	Fri, 25 Sep 2026 07:48:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790322511;
	bh=Kd+dZt0TGOfSnvGdfX5pWssQ2kt71o1V7ndjsLYU/Cg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=EmM9nHBJh+OcO5MwAG4LEsWCl3ouslsYXNccQTR83Ktcn2tX0V8conmSVpTcdKEU2
	 gSZeYQrCFObBNcon+V11zSMh1XN0zLhpPkh9v47JNk1NAuTRP/ENVgKrVNjpaSzfI0
	 18T4EgGv0vQtoN+i4oxN8YfCzq84CHEWgrNoguJ1obInjJ6p04jxCn+BrSw/UEMSaU
	 Ihs28+r2pz5zD4XUynRtOQHnRi1yKEZCp6y48eX50hFm/C3uz9u3T27LEN/79fg/FS
	 xty9eK0M76tjTycIBb8s/k2matL//IZZy6j20JGZkcVqmQxSOjsFBZjulPEMiWS9Ju
	 +0ejV76Gg1cWQ==
From: Lorenzo Pieralisi <lpieralisi@kernel.org>
Date: Fri, 25 Sep 2026 09:48:02 +0200
Subject: [PATCH RFC 03/11] driver core: platform: Add static ACPI nodes IRQ
 retrieval/mapping code
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260925-acpi-static-table-irq-probe-defer-v1-3-2c62125d0085@kernel.org>
References: <20260925-acpi-static-table-irq-probe-defer-v1-0-2c62125d0085@kernel.org>
In-Reply-To: <20260925-acpi-static-table-irq-probe-defer-v1-0-2c62125d0085@kernel.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>, 
 Mark Rutland <mark.rutland@arm.com>, Marc Zyngier <maz@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@kernel.org>, 
 Thomas Gleixner <tglx@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Danilo Krummrich <dakr@kernel.org>, Hanjun Guo <guohanjun@huawei.com>, 
 Sudeep Holla <sudeep.holla@kernel.org>, 
 Wim Van Sebroeck <wim@linux-watchdog.org>, 
 Guenter Roeck <linux@roeck-us.net>, Robin Murphy <robin.murphy@arm.com>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
 Bartosz Golaszewski <brgl@kernel.org>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, driver-core@lists.linux.dev, 
 linux-watchdog@vger.kernel.org, Lorenzo Pieralisi <lpieralisi@kernel.org>
X-Mailer: b4 0.15.2

ACPI static fwnodes types are not contemplated in the current

platform_get_irq_affinity()

implementation that is there to retrieve and map IRQs for a device.

Add fwnode_irq_get() to platform_get_irq_affinity() for static ACPI fwnodes
to overcome this shortcoming, enabling IRQ retrieval and mapping for the
ACPI static fwnode type.

Signed-off-by: Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Danilo Krummrich <dakr@kernel.org>
---
 drivers/base/platform.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/base/platform.c b/drivers/base/platform.c
index 66f9ec73d47e..413c73332308 100644
--- a/drivers/base/platform.c
+++ b/drivers/base/platform.c
@@ -228,6 +228,12 @@ int platform_get_irq_affinity(struct platform_device *dev, unsigned int num,
 		goto out;
 	}
 
+	if (is_acpi_static_node(fwnode)) {
+		ret = fwnode_irq_get(fwnode, num);
+		if (ret > 0 || ret == -EPROBE_DEFER)
+			goto out;
+	}
+
 	/*
 	 * For the index 0 interrupt, allow falling back to GpioInt
 	 * resources. While a device could have both Interrupt and GpioInt

-- 
2.54.0

