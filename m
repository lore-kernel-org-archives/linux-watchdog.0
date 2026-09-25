Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 011CD396565;
	Fri, 25 Sep 2026 07:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790322496; cv=none; b=lawZxCXYgzKmrlzD5Avhq3NUMtuE3czn87AdPQt8OPFORIQN37++vVT8ABvBC2rB8On6cYifT9BTPfnz7HFMHbQnWXOqHw37guMnjSnyx+hZh9uoLrTjurRnaI6thVfqSy9sNSNGPYL/e6k8JgPI9UK1BsvgT9ddEs25LIXevnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790322496; c=relaxed/simple;
	bh=SCHiXFdq6KEtcx5hSoM38EazV3GUoVg4pkxUdXCDRts=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=r+xi4h/u97WGbd4nB5ls8iCJ29qpekCHMfQW/6yo0Xn2fCuo4L4Zdo0S+TtUjDF7oD1yWjxME2mjPoZWH8kkUd1U99fzqKzpgaFdo8vThN6chJK6lEwHutl06mj7mDS8jEEfPz1a4wtAPCGzkKFCuwLoSBxdMSLNVK8lrJ6tMDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k6/gWjyJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k6/gWjyJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E95351F000FF;
	Fri, 25 Sep 2026 07:48:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790322494;
	bh=vl10PLh4YCEMYuVn95R7Yn6YMorNMjxNfr83ppRhiKY=;
	h=From:Subject:Date:To:Cc;
	b=k6/gWjyJcALTAmN4nMuUepNHeDDwULRUDA7JG5mVJrUzIBomVL4dMkXoQqY9hMBH+
	 13vj0OjjmjLLxNos+PE5p+3Jjjg1ZzA/DCiqJAth0qwBeXI/SQ55d0xTajkQp5/AEg
	 3dI+eqw4s8qRmX/ByVv7nWRqI+8gXf+rQm9uY7/Koyt4WmQmoqYLX7Yvf0gpgaWa1g
	 dLJAROnU8ss5A9qcfc9vMFohI6cexXCZAwl/6/d1A2KhvQqFlFN8Ol3eqJ/6dt3hWS
	 sTqXYc14jNrBl7OraYO5YvKDhOqfnlA/uI2B3QFS+vOR+e3pwwQe3olwQw3ZASMlh2
	 A/PeO26kjMW3Q==
From: Lorenzo Pieralisi <lpieralisi@kernel.org>
Subject: [PATCH RFC 00/11] ACPI: ARM64: Implement IRQ mapping probe
 deferral for static table devices
Date: Fri, 25 Sep 2026 09:47:59 +0200
Message-Id: <20260925-acpi-static-table-irq-probe-defer-v1-0-2c62125d0085@kernel.org>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWNQQrCMBBFr1Jm7UCNkhK3ggdwK11kkqmOSBsnq
 Qildzfq8j0+7y+QWYUzHJoFlF+SZRorbDcNhJsfr4wSK4NpjW2d2aMPSTAXXyRg8fSoA31i0ok
 YIw+saB25zlLszC5C7STlQd6/jwucT0fo/zLPdOdQvnVY1w/uzzKeigAAAA==
X-Change-ID: 20260924-acpi-static-table-irq-probe-defer-69b976bd723d
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

On ACPI ARM64 some platform devices (ie SMMUs, MPAM, MMIO MEM timer) are
created when the respective static ACPI table (GTDT, IORT, MPAM) entries
are parsed and the platform device resources, inclusive of their 
IRQ number are stashed in the platform device resources to be used by
device drivers at probe time to retrieve the resource values.

For IRQs, this works well as long as interrupt controller drivers
managing IRQs for those devices are probed before the code creating
the  IRQ mapping out of static table GSI numbers is run, in that the
interrupt controller drivers create the IRQ domain that allow the actual
IRQ mappings.

So far, that's always been the case on ACPI ARM64 systems given that
IRQs were routed to the GICv<5 interrupt controllers (wired and MSI)
and those controllers drivers probe earlier than any code creating
GSI mappings out of static ACPI table entries.

With the advent of GICv5 - wired IRQs (former GICv3 SPIs) can be routed
to a GICv5 IWB; the IWB is modelled as a device and its IRQ domain
is created when the IWB driver probes - that might be later than
the device drivers for platform devices created out of static ACPI tables
probe, resulting in failures to map the IRQs because the IRQ domain is not
registered yet so the IRQ mapping cannot be resolved.

This RFC series aims at solving this issue and should be used as
a starting point to build a solution and hopefully get some feedback.

PATCH 4 is a fixlet, I included with the series since I noticed
while updating the arch MEM MMIO timer driver.

Herein below, some technical details behind the patchset decisions
and questions to be addressed.

================
Misc design info
================

The main idea behind the patchset is relying on software nodes
properties to allow static tables parsing code to stash GSI number,
trigger and polarity (and possibly its "name") into the device
secondary firmware node so that the device drivers can retrieve
their values in a uniform manner when the device drivers probe,
the same way it is done on OF.

I converted IORT table platform devices to provide an example of
what it looks like and check whether that's the right direction of travel.

The secondary software node are linked to the primary ACPI static fwnode
that are already created for IORT platform devices.

A question I have about this approach is that resources for a given
device are stored in separate data, struct resource for MMIO address
space and secondary fwnode for IRQ properties.

I am not sure either that using software node properties for this
purpose is the right approach.

At least, by creating "standard" properties we can make the parsing
uniform, instead of relying on a per driver platform data to stash
GSI information as it is done for the arch MMIO mem timer.

I decided to handle the arch MMIO timer conversion differently as
a point solution. Converting the arch MMIO timer to software nodes
would require creating an ACPI static fwnode per-frame and would
complicate things for not much. Instead, I just stash the GSI
number and properties in static data per frame (that exists already,
struct arch_timer_mem_frame) at GTDT parse time that can be
used by the driver later to map the GSI when the MMIO timer driver
probes.

acpi_register_gsi() was augmented to return -EPROBE_DEFER to handle
a missing IRQ domain and therefore enabling probe deferral.

The fwnode API was augmented as well so that device drivers can actually
retrieve IRQ numbers using standard platform device APIs:

platform_get_irq*()

when the fwnode itself is an ACPI static fwnode value.

I tested this on a GICv5 FVP model by re-routing MMIO timer, SBSA watchdog
and SMMUv3 IRQs to an IWB and checking that IRQ mappings and probe deferral
work.

Feedback more than welcome.

Signed-off-by: Lorenzo Pieralisi <lpieralisi@kernel.org>
---
Lorenzo Pieralisi (11):
      ACPI: irq: Return -EPROBE_DEFER on missing IRQ domain
      ACPI: Introduce irq_get() for static fwnodes
      driver core: platform: Add static ACPI nodes IRQ retrieval/mapping code
      clocksource/drivers/arm_arch_timer_mmio: Dispose IRQ mappings on probe failure
      clocksource/drivers/arm_arch_timer_mmio: Implement arch mem timer deferred probe
      ACPI: GTDT: Convert SBSA watchdog to IRQ properties
      ACPI/IORT: Convert IORT devices to IRQs software-node properties
      watchdog: sbsa: Handle IRQ probe deferral
      iommu/arm-smmu: Add arm-smmu IRQ mapping -EPROBE_DEFER handling
      iommu/arm-smmu-v3: Add IRQ mapping -EPROBE_DEFER handling
      perf/arm-smmu-v3-pmu: Add IRQ mapping -EPROBE_DEFER handling

 drivers/acpi/arm64/gtdt.c                   |  90 ++++++----
 drivers/acpi/arm64/iort.c                   | 250 ++++++++++++++++------------
 drivers/acpi/irq.c                          |   6 +
 drivers/acpi/property.c                     |  69 +++++++-
 drivers/base/platform.c                     |   6 +
 drivers/clocksource/arm_arch_timer_mmio.c   | 123 ++++++++++++++
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c |   8 +
 drivers/iommu/arm/arm-smmu/arm-smmu.c       |   6 +-
 drivers/perf/arm_smmuv3_pmu.c               |   3 +
 drivers/watchdog/sbsa_gwdt.c                |   2 +
 include/clocksource/arm_arch_timer.h        |   4 +
 include/linux/acpi.h                        |   4 +
 12 files changed, 426 insertions(+), 145 deletions(-)
---
base-commit: cee9395acd8043be0644b25c34bfa86623f2b935
change-id: 20260924-acpi-static-table-irq-probe-defer-69b976bd723d

Best regards,
--  
Lorenzo Pieralisi <lpieralisi@kernel.org>

