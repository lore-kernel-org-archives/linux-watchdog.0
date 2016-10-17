Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from smtp684.redcondor.net ([208.80.206.84]:35804 "EHLO
        smtp684.redcondor.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932335AbcJQKnJ (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Mon, 17 Oct 2016 06:43:09 -0400
Received: from astoria.ccjclearline.com ([64.235.106.9])
          by smtp684.redcondor.net ({700db0a8-6fb7-4c8b-9b2a-6812225182d8})
          via TCP (outbound) with ESMTPS id 20161017104307756_0684
          for <linux-watchdog@vger.kernel.org>;
          Mon, 17 Oct 2016 10:43:07 +0000
Received: from [216.191.234.70] (port=24304 helo=crashcourse.ca)
        by astoria.ccjclearline.com with esmtpsa (TLSv1:AES256-SHA:256)
        (Exim 4.80)
        (envelope-from <rpjday@crashcourse.ca>)
        id 1bw5Nm-0004Az-4d
        for linux-watchdog@vger.kernel.org; Mon, 17 Oct 2016 06:43:02 -0400
Date: Mon, 17 Oct 2016 06:42:07 -0400 (EDT)
From: "Robert P. J. Day" <rpjday@crashcourse.ca>
To: Linux watchdog mailing list <linux-watchdog@vger.kernel.org>
Subject: is watchdog_ops stop() routine mandatory or optional?
Message-ID: <alpine.LFD.2.20.1610170638260.6042@ca624034.mitel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org


  continuing with annoying pedantry, there's this from
Documentation/watchdog/watchdog-kernel-api.txt:

  The list of watchdog operations is defined as:

  struct watchdog_ops {
        struct module *owner;
        /* mandatory operations */
        int (*start)(struct watchdog_device *);
        int (*stop)(struct watchdog_device *);
        /* optional operations */
        ... snip ...

followed shortly by:

Some operations are mandatory and some are optional. The mandatory operations
are:
* start: this is a pointer to the routine that starts the watchdog timer
  device.
  The routine needs a pointer to the watchdog timer device structure as a
  parameter. It returns zero on success or a negative errno code for failure.

Not all watchdog timer hardware supports the same functionality. That's why
all other routines/operations are optional. They only need to be provided if
they are supported. These optional routines/operations are:
* stop: with this routine the watchdog timer device is being stopped.
... snip ...

  so the first snippet implies that stop() is mandatory, while the
subsequent snippet describes it as optional. thoughts?

rday

p.s. i am currently editing this doc file, and will submit an updated
version with little fixes throughout.

-- 

========================================================================
Robert P. J. Day                                 Ottawa, Ontario, CANADA
                        http://crashcourse.ca

Twitter:                                       http://twitter.com/rpjday
LinkedIn:                               http://ca.linkedin.com/in/rpjday
========================================================================

