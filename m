Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794576293;
	b=QptRJ8GKb6q4fbEwL4y8Bsrjo4oVo6PAo/S7EwH02vS2KnDcOg+nyi59a9MfQ6yQaV04
	 Lo+mw4B8qDmzwL9LsTAI/ITde7h4acmRlBHSl1bIpP63EOJ6K5y1gLSpRxrwCdPClaQya
	 GslwgXfyKLOjsOSuZrqHLMcsrKxrV/YVT1eUgXMSiGCYzyspuvemssTYw4AfgFdck6b1M
	 mTpBcV1IQtymnnz48dqFcEDjTUX1k5WNCLCp7FjFs6KWkXjXYCxHFAjywndnGHe5i1OnE
	 ox9fl4vppAZMlGOS3oCS7kxe+M8ujBtXD3+KxtUTK6vmvrWBWXWs5UhEmHPoz18KIAQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794576293;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=20q7fyL44IefQuhPWlx1GZf/JmbaLKjuNxOAz7TK1Bo=;
	b=tph2XQOyuBtWwaMoIuCAxqxFnumh+MfdoxwfTZOhuQ6SH16CsfN/0pwfDsFQT7Vxllp3
	 UCFdtYM+rIPWmg3KDU6DGjDYDc9sNzyeJIGT8mowsm1rxOUELnqIYqqeBmzGfVzP3XIlj
	 grd3yIGkkCRSFlEQCOGVDnCn1QvbI4eOnswCgkdjB9FYobTLykJw5XKHTBaJz+f6kcvdz
	 1Es00wQgtbILNsnpywOHL/jJR7MqYvsq+7tfY+xZBYHCysdyrffUaKKGi2Z/+ITFpRjGv
	 DQx5j1JZ9YIy/RgAnDHIKl4+0bvckE7+nBI+Fx0kGcIekWwXYdJXRz2mcepuUpHdX7g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wtJ38hN7;
	arc=none smtp.remote-ip=209.85.218.45
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE2C2606A323
	for <linux-watchdog@vger.kernel.org>; Fri, 13 Nov 2026 13:24:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EE2C2606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wtJ38hN7
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-c4682977f9aso193788966b.1
        for <linux-watchdog@vger.kernel.org>; Fri, 13 Nov 2026 05:24:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794576291; x=1795181091; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=20q7fyL44IefQuhPWlx1GZf/JmbaLKjuNxOAz7TK1Bo=;
        b=wtJ38hN7c8113rv+J4rUT1dC8MrzAxD7vaxWDOZ3TTdSK2jznYI7Kkqq68+xrQpKJz
         R/sHrAod4N9AxbJ6IQcukUudRkUP0fBhZfnFFhxCMFzM7leW8ZzGBefhRvVmBLy9/n21
         6Th0Fa3fs+EvBECBDIVH+ifvs6WG6JAbs4pjDR3BeiN0LBxDfjdRS7BYNLAHsZWb9gmY
         qwzqhqs8Y/x6ZR2jvKlg2JwvmMCCUHmNZ7lqL5lVgZMRVkHVRasAulguCQIOxj5tw+1m
         5KZt5K1CdSZyU22QP+ehMDaXvqUbOWVE97O1KRp5IO30QK6tPrCihfHBjHBmqrnPL9q4
         wwSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794576291; x=1795181091;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=20q7fyL44IefQuhPWlx1GZf/JmbaLKjuNxOAz7TK1Bo=;
        b=sez+H/2XAaqFZi1TjE3icC+MILiS/dzBGuNQoOW8QcTx9YVSk3ypLwTmchqz+l3icj
         61I3hMPYIvTUJDgjGzg0+x0qr2XHx0PKPM1d4tBocutEmMKMA5zqN09vsXrW6H5BIEzZ
         oYGWHSkAuUX6S/knIgN5YfbFf6mskRB33IQQ4KY3ix6nWfnaDDY5tagbWZL7Q6M/Ltgl
         3OTdw7lk72UYPb6BPjwhvLCtc0Z3qLFFoRpWgQN7MpRNwrgAwzkJVxawd4sTwj6F9LvL
         5SBZ7GdloGr4TwGOWytdTpRgACJPV71kvM+VXYXq7mV4Zv5HR/XviRhHFhVpKJXx+8Ry
         v/1Q==
X-Forwarded-Encrypted: i=1; AL+hErGjOXjn8sKRooriz4zh4DcKhN7CtEC6a3/ye8XqBAPnS9Z7ZdTTbwJR0i+8TL0OxSvWM3Dmop172L/bRmJq0w==@vger.kernel.org
X-Gm-Message-State: APuU4Z9DJ780ub0I193LLAXgcuXARmKCTezwqqzzXGt2Cq4bDOaXyfOm
	HG2QSJIYovh3gyUlJ3T0gGmrDL4rUDonANu4fpIkvB83Nb5Wt7oQXp+9
X-Gm-Gg: AYBFou2m3x1CKC/l3OoZydmAxweRFYlsiO86PO5QEDDlO6n/34DtvGuTl0tp01t/BGf
	XU0eaY8iEVBYNiAliwa5q0Jv4+jau3FSgOjTlNtEgwoejKoBwECrBJ0iRI679FFYQzvFIvReG43
	RBLio0m2kxVzF47F4wZ/XnSeFCOXSd3PuSpIKLejEKc2yw/TO8mOEhdUTvO1by6gOibX3mfuvSB
	hIPMDQCP7sLywjYgWmnoSpW7KNtC3HbHk2R8NXcZqqr0DWevgURVhOSlegiB7N+2Ruvm7ItgY0n
	SHVpnFqA0sxnIs2eAZYzWL6mVn+DorM2tw7TTd+5mjFJeFg8CCQlEx7vLPLlpSPS3DjW8wsolWm
	apE55JBkt+DtBuMX1iiDf9TKn/vgw9IBZFix1bwf2jnYEi8pS+gutI4r71lUrrcuUiOK5dUogRg
	RC5TYS5PztbmoyuSNgLBCh1D6IBu81USJ0GIrCtODPtI9lShRmSaCtUUe/bIb40676UTFz1QD4l
	v1wPhSAoi0zuP9Fb+nLQTR/1ckoBjc2Ti9B5J5aU/EpYrdJUlFniMQuMVdsMfP5l4vOix4rs2u7
	vOW3Igkomh/ldgwY0kyjI2waHVzkvpu7jgzrYCz0lZAEssXur9WkyJKeNlmMSR64D468iTViFYl
	Hltng4Gg=
X-Received: by 2002:a17:907:72c8:b0:c2d:c98f:4824 with SMTP id a640c23a62f3a-c509640e213mr207866666b.30.1794576291197;
        Fri, 13 Nov 2026 05:24:51 -0800 (PST)
Received: from alchark-surface.localdomain (bba-86-98-194-229.alshamil.net.ae. [86.98.194.229])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49c60f8d66esm4680211f8f.57.2026.11.13.05.24.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 05:24:50 -0800 (PST)
From: Alexey Charkov <alchark@gmail.com>
Subject: [PATCH v7 0/4] clocksource/drivers/timer-vt8500: clean up and add
 watchdog function
Date: Fri, 13 Nov 2026 17:24:39 +0400
Message-Id: <20261113-vt8500-timer-updates-v7-0-a1dcc4031b12@gmail.com>
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
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/43QwWrDMAwG4FcpPs9DUmy522nvMXpwYrk1LE2Js
 9BR8u5zCoWQLdDjL9D3I91Ulj5JVu+7m+plTDl15xLcy041J38+ik6hZEVAFiywHoe9BdBDaqX
 X35fgB8naGA+BqAmOQJXVSy8xXe/s56HkU8pD1//cW0acpw/Q/Q+OqEFz7Ti6WBnw/HFsffp6b
 bpWzeBIzyA0I1ZswBr21soaqRYI2g2kKgjhm/MFYarDGjELhHADMTMSTAXskb2YNWKfQWxBnJg
 6IIbo6M85/EAYEWkD4YLEgI14NuUxcYlM0/QLYQlwPxECAAA=
X-Change-ID: 20250506-vt8500-timer-updates-44a0d22cd720
To: Alexey Charkov <alchark@gmail.com>, 
 Krzysztof Kozlowski <krzk@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@kernel.org>, 
 Thomas Gleixner <tglx@kernel.org>, 
 Wim Van Sebroeck <wim@linux-watchdog.org>, 
 Guenter Roeck <linux@roeck-us.net>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-watchdog@vger.kernel.org
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5147; i=alchark@gmail.com;
 h=from:subject:message-id; bh=3vAzwPDkYxTNwi1y600ys71JIPozJFxUEKDzhpDEevY=;
 b=owGbwMvMwCW2adGNfoHIK0sZT6slMWR951/gm5FW4ql5f+uZDRHicla7csud7AXEX+1MMN0w8
 ZlwwYLajoksDGJcDJZiiixzvy2xnWrEN2uXh8dXmDmsTCBDpEUaGICAhYEvNzGv1EjHSM9U21DP
 0EjHWMeIgYtTAKb6XTgjw/ELNnuFw3d4sX+siLK0nWdl6lOyc/2n486z8s7mhOrW+zMyTJoa+em
 67ec5S36t888P91ylOvWsxpXfSUrrjuye7HRFnhcA
X-Developer-Key: i=alchark@gmail.com; a=openpgp;
 fpr=9DF6A43D95320E9ABA4848F5B2A2D88F1059D4A5

Add named defines for the registers and bits in timer-vt8500.
Move the system events timer from channel 0 to channel 1 when enough
information is provided by the device tree (i.e. more than one IRQ).
Use channel 0 for the system watchdog, and let the watchdog restart the
SoC, which the machine's own restart hook fails to do on WM8950.

Signed-off-by: Alexey Charkov <alchark@gmail.com>
---
Changes in v7:
- Rebased onto next-20261112
- Register the restart handler at priority 0, the last resort, so that
  it runs after the machine's own restart hook regardless of
  registration order (thanks Guenter)
- Wait for the reset to assert after arming the watchdog in the restart
  handler, rather than return and let later handlers run (thanks Guenter)
- Link to v6: https://patch.msgid.link/20261112-vt8500-timer-updates-v6-0-fd1cea645d1f@gmail.com

Changes in v6:
- Dropped the binding patch, which Rob has applied
- Rebased onto next-20261111
- Moved the shared header under include/clocksource (thanks Daniel)
- Pass the watchdog a single register base, and keep the watchdog
  register offsets in its own driver (thanks Daniel)
- Build the watchdog driver in rather than as a module: the timer it
  depends on is always built in, and the driver is tiny (thanks Daniel)
- kfree the correct structure upon aux child release (thanks Daniel)
- Return -ENODEV rather than -ENOMEM if the timer failed to initialize,
  and drop the message on allocation failure (thanks Daniel)
- Unmap the timer registers if its interrupt is missing, so that no
  watchdog gets created on a timer that never started
- Improved code comments and commit messages (thanks Daniel)
- Give the watchdog a default timeout, so that opening the device
  before setting one no longer arms it for the next counter wraparound
- Wait for a pending match register write to settle before rewriting it,
  as the clock event code does
- Honour the nowayout parameter, and disallow unbinding the watchdog,
  which would leave it armed with nothing to ping it
- Added a restart handler, so that reboot works on WM8950
- Link to v5: https://lore.kernel.org/r/20250521-vt8500-timer-updates-v5-0-7e4bd11df72e@gmail.com

Changes in v5:
- Make sure the watchdog timeout value is clamped to hardware limits
  before writing it to the registers (thanks Guenter)
- Add a comment about the watchdog match value (deadline) wrapping around
  the U32_MAX boundary, which is expected behavior (thanks Guenter)
- Avoid moving register definitions to the shared header file to reduce
  churn: the watchdog driver gets direct pointers to the two registers it
  uses anyway, so it doesn't have to know all those offsets and bits
- Put the watchdog Kconfig entry with other ARM platforms where it belongs
- Link to v4: https://lore.kernel.org/r/20250521-vt8500-timer-updates-v4-0-2d4306a16ae4@gmail.com

Changes in v4:
- Changed the watchdog driver to use auxiliary bus instead of platform
  (thanks Guenter)
- Split out the register definitions into a header file shared between
  the clocksource driver and the watchdog driver
- Replaced -1UL with U32_MAX in watchdog max_heartbeat_ms to make builds
  on non-32bit platforms happier
- Link to v3: https://lore.kernel.org/r/20250515-vt8500-timer-updates-v3-0-2197a1b062bd@gmail.com

Changes in v3:
- Dropped the DTS patch already applied by Krzysztof
- Rebased onto v6.15-rc5 as requested by Daniel
- Split out the watchdog code into a dedicated platform driver, like
  timer-gxp does (thanks Daniel)
- Link to v2: https://lore.kernel.org/r/20250507-vt8500-timer-updates-v2-0-65e5d1b0855e@gmail.com

Changes in v2:
- Included the previously reviewed binding change that is directly related
  to this series as the first patch here (thanks Krzysztof)
- Created a separate config symbol for the watchdog function to let users
  build a kernel without forcing watchdog functionality upon them
  (thanks Krzysztof)
- Link to the previous binding submission: https://lore.kernel.org/all/20250506-via_vt8500_timer_binding-v3-1-88450907503f@gmail.com/

---
Alexey Charkov (4):
      clocksource/drivers/timer-vt8500: Add defines for magic constants
      clocksource/drivers/timer-vt8500: Prepare for watchdog functionality
      watchdog: Add support for VIA/WonderMedia SoC watchdog functionality
      watchdog: vt8500: Add a restart handler

 Documentation/watchdog/watchdog-parameters.rst |   7 +
 MAINTAINERS                                    |   2 +
 drivers/clocksource/Kconfig                    |   1 +
 drivers/clocksource/timer-vt8500.c             | 179 +++++++++++++++++++++----
 drivers/watchdog/Kconfig                       |  12 ++
 drivers/watchdog/Makefile                      |   1 +
 drivers/watchdog/vt8500-wdt.c                  | 150 +++++++++++++++++++++
 include/clocksource/vt8500-timer.h             |  22 +++
 8 files changed, 347 insertions(+), 27 deletions(-)
---
base-commit: 6d582d78fad9d828e575ca0cdcff8ea47a77220b
change-id: 20250506-vt8500-timer-updates-44a0d22cd720

Best regards,
--  
Alexey Charkov <alchark@gmail.com>

